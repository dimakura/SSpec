/// Node for specs tree.
class Node: Equatable, Hashable {
  /// Current node: used for running examples.
  static var current: Node? = nil

  /// Equatable implementation.
  static func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
  }

  /// Unique identificator of this node.
  let id: Int

  /// Is this example focused?
  let focused: Bool

  /// Parent node.
  let parent: Node?

  /// Description of the node.
  let title: String

  /// Executable for this node.
  let runnable: SSRunnable?

  /// Is this a root node?
  var isRoot: Bool { return false }

  /// Child nodes.
  var children = [Node]()

  /// Children which are run before everything else.
  var preChildren = [Node]()

  /// Children which are run after everything else.
  var postChildren = [Node]()

  /// Creates node.
  init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil, focused: Bool = false) {
    self.id = IdGenerator.nextId

    self.focused  = parent?.focused ?? false || focused
    self.parent   = parent
    self.title    = title
    self.runnable = runnable

    if let par = parent {
      par.children.append(self)
    }
  }

  var hashValue: Int {
    return id
  }

  /// Execute some code in node's context.
  func with(_ node: Node? = nil, _ runnable: SSRunnable?) {
    let previous = Node.current
    Node.current = node ?? self
    if let run = runnable {
      run()
    }
    Node.current = previous
  }

  /// If this node is current one?
  var isCurrentNode: Bool {
    return self == Node.current
  }

  /// Is this node focused?
  var isFocused: Bool {
    return SSpec.currentSession.isFocused(self)
  }

  /// Full title of the node.
  var fullTitle: String {
    if let parent = self.parent {
      return parent.isRoot ? title : "\(parent.fullTitle) \(title)"
    }

    return title
  }

  /// Full chain from current not to the root..
  var chain: [Node] {
    guard let par = parent else { return [self] }

    var c = par.chain
    c.append(self)
    return c
  }

  /// Collects preChildren from parent and adds self preChildren.
  func allPreChildren() -> [Node] {
    var pres = [Node]()

    if let par = parent {
      for pre in par.allPreChildren() {
        pres.append(pre)
      }
    }

    for pre in self.preChildren {
      pres.append(pre)
    }

    return pres
  }

  /// Adds parent prechildren to self's preChildren.
  func allPostChildren() -> [Node] {
    var posts = [Node]()

    for post in self.postChildren {
      posts.append(post)
    }

    if let par = parent {
      for post in par.allPostChildren() {
        posts.append(post)
      }
    }

    return posts
  }

  /// Session invokes this method during initialization mode.
  func runInitialization() {}

  /// Session invokes this method during testing mode.
  func runTesting() {}

  /// Standard code for executing child nodes.
  /// Root and context nodes both use it in testing mode.
  func runChildNodes() {
    func runPres() {
      for pre in allPreChildren() {
        pre.runTesting()
      }
    }

    func runPosts() {
      for post in allPostChildren() {
        post.runTesting()
      }
    }

    for child in self.children {
      with(child) {
        runPres()
        child.runTesting()
        runPosts()
      }
    }
  }
}

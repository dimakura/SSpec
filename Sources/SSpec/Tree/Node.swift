/// Node for specs tree.
class Node: Equatable {
  /// Current node: used for running examples.
  static var current: Node? = nil

  /// Equatable implementation.
  static func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
  }

  /// Unique identificator of this node.
  let id: Int

  /// Parent node.
  let parent: Node?

  /// Level starts with `-1` for root node and goes up each new level.
  let level: Int

  /// Description of the node.
  let title: String

  /// Executable for this node.
  let runnable: SSRunnable?

  /// Is this a root node?
  var isRoot: Bool { return false }

  /// Child nodes.
  var children: [Node]

  /// Children which are run before everything else.
  var preChildren: [Node]

  /// Children which are run after everything else.
  var postChildren: [Node]

  /// Creates node.
  init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    self.id = IdGenerator.nextId
    self.parent = parent
    self.level = (parent?.level ?? -2) + 1
    self.title = title
    self.runnable = runnable
    self.children = [Node]()
    self.preChildren = [Node]()
    self.postChildren = [Node]()

    if let par = parent { par.children.append(self) }
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

  /// Full title of the node.
  var fullTitle: String {
    if let parent = self.parent {
      return parent.isRoot ? title : "\(parent.fullTitle) \(title)"
    }
    return title
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

  /// This method runs during initialization.
  func runInitialization() {}

  /// This method runs during test mode.
  func runTesting() {}

  /// Standard code for executing child nodes.
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

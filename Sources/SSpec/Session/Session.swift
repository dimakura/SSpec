/// Interface for running specs.
public class SSSession {
  /// Session mode.
  enum Mode {
    /// Mode when we build execution tree.
    case Initializing

    /// Mode when tests are executed.
    case Testing
  }

  /// Current node.
  /// During initialization this node is used to build execution tree.
  /// During run this is usually a root node.
  var _currentNode: Node

  let collectors: [Collector]

  private var _mode: Mode?
  private var _hasErrors: Bool = false
  private var _exampleCount: Int = 0
  private var _focused: Set<Node>

  /// Session mode.
  var mode: Mode { return _mode! }

  /// Result of running this session.
  var hasErrors: Bool { return _hasErrors }

  /// Example count.
  var exampleCount: Int { return _exampleCount }

  /// Create session.
  init() {
    _currentNode = Root(title: "ROOT")
    _focused = Set<Node>()
    collectors = [
      Welcomer(),
      Reporter.createReporter(),
      TimeTaken()
    ]
  }

  /// Mark current session as having errors.
  func markError() {
    _hasErrors = true
  }

  /// Incremenet examples count.
  func incExamples() {
    _exampleCount += 1
  }

  /// Register focused example.
  func addFocused(_ node: Node) {
    _focused = _focused.union(node.chain)
  }

  /// Is given node focused?
  /// This method returns true if there are no focused specs.
  func isFocused(_ node: Node) -> Bool {
    if _focused.isEmpty {
      return true
    }

    return _focused.contains(node)
  }

  /// Execute session.
  func execute(_ runnable: SSRunnable) {
    execInitializationMode(runnable: runnable)
    execRunningMode(runnable: runnable)
  }

  private func execInitializationMode(runnable: SSRunnable) {
    _mode = .Initializing
    runnable()
  }

  private func execRunningMode(runnable: SSRunnable) {
    _mode = .Testing
    _currentNode.runTesting()
  }
}

/// Shorthad notation.
public typealias SSS = SSSession

/// Runnable type.
public typealias SSRunnable = () -> Void

/// Main interface to interact.
public struct SSpec {
  static let currentVersion = Version(major: 0, minor: 2, patch: 1)

  /// Kind of reporter.
  public enum Reporter {
    case Dot
    case Spec
    case Progress
  }

  private static var _currentSession: SSSession?

  /// Current session.
  static var currentSession: SSSession { return _currentSession! }

  /// Current reporter.
  static var reporter: Reporter = .Dot

  /// You use this method only once for running sessions.
  public static func run(_ runnable: SSRunnable) {
    _currentSession = SSSession()
    currentSession.execute(runnable)
  }

  /// Where there errors?
  public static var hasErrors: Bool {
    return _currentSession?.hasErrors ?? false
  }

  /// How many examples were run?
  public static var exampleCount: Int {
    return _currentSession?.exampleCount ?? 0
  }
}

/// Create expectation object.
public func expect<T>(_ value: T?) -> SSExpect<T> {
  return SSExpect<T>(value)
}

/// Change expectation.
public func expect(_ runnable: @escaping SSRunnable) -> SSExpect<SSChange> {
  let change = SSChange(runnable)
  return SSExpect<SSChange>(change)
}

/// Describe function.
public func describe(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Context function.
public func context(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Before hook.
public func before(_ runnable: SSRunnable?) {
  SSpec.currentSession.before(runnable)
}

/// Example function.
public func it(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.it(title, runnable)
}

/// After hook.
public func after(_ runnable: SSRunnable?) {
  SSpec.currentSession.after(runnable)
}

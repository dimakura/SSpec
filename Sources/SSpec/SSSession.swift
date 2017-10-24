//
// SSpec
// SSSession.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Session running modes.
enum SessionMode {
  /// Initial phase: initialization.
  case Initializing

  /// Phase for running actual examples.
  case Running

  /// Final reporting phase.
  case Finalizing
}

/// Main interface for running specs.
///
/// ```swift
/// let result = SSS.run(spec in {
///   spec.it("2 * 2 = 4", {
///     spec.expect(2 * 2).to.eq(4)
///   })
/// })
/// XCTAssert(result, "Some specs are failing.")
/// ```
public class SSSession {
  /// Currently executing session.
  static var _currentSession: SSSession?
  static var currentSession: SSSession { return _currentSession! }

  /// You use this method only once for running sessions.
  public static func run(_ runnable: (SSMatcher) -> Void) -> Bool {
    guard _currentSession == nil else { fatalError("Another session is already running.") }

    _currentSession = SSSession()
    currentSession.execute(runnable)

    return !currentSession.hasErrors
  }

  /// Session matcher.
  let matcher: SSMatcher

  private var _mode: SessionMode?

  /// If current session has errors?
  private var _hasErrors: Bool = false
  var hasErrors: Bool { return _hasErrors }

  /// Current session mode.
  var mode: SessionMode {
    return _mode!
  }

  /// Session listeners.
  private let listeners: [SSSessionListenerProtocol]

  /// Create session.
  init() {
    matcher = SSMatcher()

    listeners = [
      Welcomer(),
      ProgressReporter(),
      TimeTaken()
    ]
  }

  /// Execute session.
  func execute(_ runnable: (SSMatcher) -> Void) {
    _mode = .Initializing
    matcher.execInitMode(runnable)

    _mode = .Running
    matcher.execRunMode(runnable)

    // _mode = .Finalizing
    // runnable(matcher)
  }
}

extension SSSession {
  private func notifyAll(_ fireListener: (SSSessionListenerProtocol) -> Void) {
    for listener in self.listeners {
      fireListener(listener)
    }
  }

  func fireSpecStarted() {
    notifyAll { listener in listener.specStarted() }
  }

  func fireContextStarted(node: DescribeNode) {
    notifyAll { listener in listener.contextStarted(node: node) }
  }

  func fireExampleSkipped(node: ExampleNode) {
    notifyAll { listener in listener.exampleSkipped(node: node) }
  }

  func fireExampleStarted(node: ExampleNode) {
    notifyAll { listener in listener.exampleStarted(node: node) }
  }

  func fireExampleError(error: String) {
    _hasErrors = true
    notifyAll { listener in listener.exampleError(error: error) }
  }

  func fireExampleEnded(node: ExampleNode) {
    notifyAll { listener in listener.exampleEnded(node: node) }
  }

  func fireContextEnded(node: DescribeNode) {
    notifyAll { listener in listener.contextEnded(node: node) }
  }

  func fireSpecEnded() {
    notifyAll { listener in listener.specEnded() }
  }
}

public typealias SSS = SSSession

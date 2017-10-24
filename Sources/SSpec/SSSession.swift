//
// SSpec
// SSSession.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Running modes for SSSession.
enum SessionMode {
  /// Phase when we build execution tree.
  case Initializing

  /// Phase when examples are run.
  case Running
}

/// Interface for running specs.
///
/// ```swift
/// let session = SSS.run {
///   it("2 + 2 = 4") {
///     expect(2 + 2).to.eq(4)
///   }
/// }
/// XCTAssert(session.hasErrors == false, "Some specs are failing.")
/// ```
public class SSSession {
  /// Currently executing session.
  static var _currentSession: SSSession?
  static var currentSession: SSSession { return _currentSession! }

  /// You use this method only once for running sessions.
  public static func run(_ runnable: SSRunnable) -> SSS {
    _currentSession = SSSession()
    currentSession.execute(runnable)
    return currentSession
  }

  /// Session matcher.
  let matcher: SSMatcher

  private var _mode: SessionMode?
  private var _hasErrors: Bool = false
  private var _exampleCount: Int = 0
  private let listeners: [SSSessionListenerProtocol]

  /// Current session mode.
  var mode: SessionMode { return _mode! }

  /// Result of running this session.
  public var hasErrors: Bool { return _hasErrors }

  /// Example count.
  public var exampleCount: Int { return _exampleCount }

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
  func execute(_ runnable: SSRunnable) {
    execInitializationMode(runnable: runnable)
    execRunningMode(runnable: runnable)
  }

  private func execInitializationMode(runnable: SSRunnable) {
    _mode = .Initializing
    matcher.execInitMode(runnable)
  }

  private func execRunningMode(runnable: SSRunnable) {
    _mode = .Running
    matcher.execRunMode(runnable)
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
    _exampleCount += 1
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

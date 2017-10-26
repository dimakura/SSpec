//
// SSpec
// SSSession.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Interface for running specs.
///
/// ```swift
/// let session = SSS.run {
///   it("2 + 2 = 4") {
///     expect(2 + 2).to.eq(4)
///   }
/// }
/// XCTAssert(session.hasErrors == false)
/// ```
public class SSSession {

  /// Session mode.
  enum Mode {
    /// Mode when we build execution tree.
    case Initializing

    /// Mode when examples are run.
    case Running
  }

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

  private var _mode: Mode?
  private var _hasErrors: Bool = false
  private var _exampleCount: Int = 0
  private let collectors: [Collector]

  /// Session mode.
  var mode: Mode { return _mode! }

  /// Result of running this session.
  public var hasErrors: Bool { return _hasErrors }

  /// Example count.
  public var exampleCount: Int { return _exampleCount }

  /// Create session.
  init() {
    matcher = SSMatcher()

    collectors = [
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
  /// Base class for collecting session related events.
  class Collector {
    func specStarted() {}
    func contextStarted(node: DescribeNode) {}
    func exampleSkipped(node: ExampleNode) {}
    func exampleStarted(node: ExampleNode) {}
    func exampleError(error: String) {}
    func exampleEnded(node: ExampleNode) {}
    func contextEnded(node: DescribeNode) {}
    func specEnded() {}
  }

  private func emitAll(_ emit: (Collector) -> Void) {
    for collector in self.collectors {
      emit(collector)
    }
  }

  func collectSpecStarted() {
    emitAll { collector in collector.specStarted() }
  }

  func collectContextStarted(node: DescribeNode) {
    emitAll { collector in collector.contextStarted(node: node) }
  }

  func collectExampleSkipped(node: ExampleNode) {
    emitAll { collector in collector.exampleSkipped(node: node) }
  }

  func collectExampleStarted(node: ExampleNode) {
    _exampleCount += 1
    emitAll { collector in collector.exampleStarted(node: node) }
  }

  func collectExampleError(error: String) {
    _hasErrors = true
    emitAll { collector in collector.exampleError(error: error) }
  }

  func collectExampleEnded(node: ExampleNode) {
    emitAll { collector in collector.exampleEnded(node: node) }
  }

  func collectContextEnded(node: DescribeNode) {
    emitAll { collector in collector.contextEnded(node: node) }
  }

  func collectSpecEnded() {
    emitAll { collector in collector.specEnded() }
  }
}

public typealias SSS = SSSession

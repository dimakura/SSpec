//
// SSpec
// SSSession.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Main interface for running specs.
///
/// ```swift
/// let result = SSS.run(sss in {
///   sss.it("2 * 2 = 4", {
///     sss.expect(2 * 2).to.eq(4)
///   })
/// })
/// XCTAssert(result, "Some specs are failing.")
/// ```
public class SSSession {
  /// Currently executing session.
  static var currentSession: SSSession?

  /// Session stats.
  private var _exampleCount = 0
  private var _failureCount = 0

  /// Session matcher.
  let matcher: SSMatcher
  private var _mode: SessionMode?

  /// You use this method only once for running sessions.
  public static func run(_ runnable: (SSMatcher) -> Void) -> Bool {
    if currentSession != nil {
      fatalError("Another session is already running.")
    }

    currentSession = SSSession()
    currentSession!.execute(runnable)

    return currentSession!.failureCount == 0
  }

  /// Create session.
  init() {
    matcher = SSMatcher()
  }

  /// Current session mode.
  var mode: SessionMode {
    return _mode!
  }

  /// Total number of examples in this session.
  var exampleCount: Int {
    return _exampleCount
  }

  /// Total number of failures in this session.
  var failureCount: Int {
    return _failureCount
  }

  /// Increment examples count.
  func exampleInc() {
    _exampleCount += 1
  }

  /// Increment failures count.
  func failureInc() {
    _failureCount += 1
  }

  /// Execute session.
  func execute(_ runnable: (SSMatcher) -> Void) {
    print("\n-- SSpec \(Version.currentVersion)\n")

    _mode = .Initializing
    matcher.execInitMode(runnable)

    _mode = .Running
    matcher.execRunMode(runnable)

    // _mode = .Finalizing
    // runnable(matcher)

    logGoodbye()
  }
}

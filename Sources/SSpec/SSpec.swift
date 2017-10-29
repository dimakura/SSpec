//
// SSpec
// SSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Runnable type.
public typealias SSRunnable = () -> Void

/// Main interface to interact.
public struct SSpec {
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

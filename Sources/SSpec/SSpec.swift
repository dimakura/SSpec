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
  private static var _currentSession: SSSession?

  static var currentSession: SSSession { return _currentSession! }

  /// You use this method only once for running sessions.
  public static func run(_ runnable: SSRunnable) {
    _currentSession = SSSession()
    currentSession.execute(runnable)
  }

  public static var hasErrors: Bool {
    return currentSession.hasErrors
  }

  public static var exampleCount: Int {
    return currentSession.exampleCount
  }
}

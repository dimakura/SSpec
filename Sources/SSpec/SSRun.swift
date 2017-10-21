//
// SSpec
// SSRun.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Foundation

fileprivate var isRunning: Bool = false

// Marks service as running.
// If previous run was detected, throw fatal error.
fileprivate func markAsRunning() {
  if isRunning {
    fatalError("Another spec is already running.")
  }
  isRunning = true
}

// Starting spec session.
fileprivate func startSession() {
  markAsRunning()
  logWelcome()
}

// End of spec session.
fileprivate func endSession() {
  logGoodbye()
}

/// Main spec runner: all specs should be run from here.
public func SSRun(_ runnable: SSRunnable) -> Bool {
  startSession()
  runnable()
  endSession()
  return failuresCount == 0
}

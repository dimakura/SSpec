//
// SSpec
// SSSessionListener.swift
//
// Created by Dimitri Kurashvili on 2017-10-22
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Foundation

/// Listener interface.
protocol SSSessionListenerProtocol {
  func specStarted()
  func contextStarted(node: DescribeNode)
  func exampleSkipped(node: ExampleNode)
  func exampleStarted(node: ExampleNode)
  func exampleError(error: String)
  func exampleEnded(node: ExampleNode)
  func contextEnded(node: DescribeNode)
  func specEnded()
}

/// Implements `SSSessionListenerProtocol` with do-nothing methods.
class SSSessionListenerAdapter: SSSessionListenerProtocol {
  func specStarted() {}
  func contextStarted(node: DescribeNode) {}
  func exampleSkipped(node: ExampleNode) {}
  func exampleStarted(node: ExampleNode) {}
  func exampleError(error: String) {}
  func exampleEnded(node: ExampleNode) {}
  func contextEnded(node: DescribeNode) {}
  func specEnded() {}
}

/// Welcome user.
class Welcomer: SSSessionListenerAdapter {
  override func specStarted() {
    print("\n-- Runing SSpec v\(Version.currentVersion)\n")
  }
}

/// This listener reports time taken by specs.
class TimeTaken: SSSessionListenerAdapter {
  var startTime: Double = 0

  override func specStarted() {
    startTime = NSDate.timeIntervalSinceReferenceDate
  }

  override func specEnded() {
    let endTime = NSDate.timeIntervalSinceReferenceDate
    var duration = endTime - startTime
    var unit = "seconds"
    if (duration < 1 && duration * 1_000 > 0.1) {
      duration = duration * 1_000
      unit = "miliseconds"
    } else if (duration < 1 && duration * 1_000_000 > 0.1) {
      duration = duration * 1_000_000
      unit = "microseconds"
    }
    print(String(format: "\nTook %.3f \(unit)\n", duration))
  }
}

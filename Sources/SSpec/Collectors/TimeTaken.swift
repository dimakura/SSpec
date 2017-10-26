//
// SSpec
// TimeTaken.swift
//
// Created by Dimitri Kurashvili on 2017-10-22
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Foundation

fileprivate func normalDuration(_ rawDuration: Double) -> (Double, String) {
  var unit = "seconds"
  var duration = rawDuration
  if (duration < 1 && duration * 1_000 > 0.3) {
    duration = duration * 1_000
    unit = "miliseconds"
  } else if (duration < 1 && duration * 1_000_000 > 0.3) {
    duration = duration * 1_000_000
    unit = "microseconds"
  }
  return (duration, unit)
}

/// This collector reports time taken to run specs.
class TimeTaken: SSSession.Collector {
  var startTime: Double = 0

  override func specStarted() {
    startTime = NSDate.timeIntervalSinceReferenceDate
  }

  override func specEnded() {
    let endTime = NSDate.timeIntervalSinceReferenceDate
    let (duration, unit) = normalDuration(endTime - startTime)
    print(String(format: "\nTook %.3f \(unit)\n", duration))
  }
}

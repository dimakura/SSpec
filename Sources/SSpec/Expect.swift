//
// SSpec
// Expect.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Stats

fileprivate var count: Int = 0
fileprivate var failures: Int = 0

func exampleInc() {
  count += 1
}

func failuresInc() {
  failures += 1
}

var examplesCount: Int {
  return count
}

var failuresCount: Int {
  return failures
}

/// Runners

import Foundation


fileprivate var failed: Bool = false


func runExample(_ runnable: SSRunnable) -> Bool {
  failed = false

  runnable()

  exampleInc()
  if (failed) {
    failuresInc()
  }

  return !failed
}


public class SSpecExpect<T: Comparable> {
  public typealias ComparableType = T

  let value: ComparableType
  private var negate: Bool = false

  init(_ value: ComparableType) {
    self.value = value
  }

  public var to: SSpecExpect {
    return self
  }

  public var be: SSpecExpect {
    return self
  }

  public var not: SSpecExpect {
    negate = true
    return self
  }

  public func beTrue(_ value: Bool) {
    let compare = negate ? !value : value
    if !compare {
      failed = true
    }
  }

  public func beFalse(_ value: Bool) {
    beTrue(!value)
  }

  public func eq(_ anotherValue: ComparableType) {
    beTrue(value == anotherValue)
  }

  public func greaterThan(_ anotherValue: ComparableType) {
    beTrue(value > anotherValue)
  }

  public func greaterOrEqualtThan(_ anotherValue: ComparableType) {
    beTrue(value >= anotherValue)
  }

  public func lessThan(_ anotherValue: ComparableType) {
    beTrue(value < anotherValue)
  }

  public func lessOrEqualThan(_ anotherValue: ComparableType) {
    beTrue(value <= anotherValue)
  }

}


extension SSpecExpect where T == String {
  public func include(_ anotherString: String) {
    beTrue(value.range(of: anotherString) != nil)
  }
}

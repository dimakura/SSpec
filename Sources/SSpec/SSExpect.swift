//
// SSpec
// SSExpect.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

fileprivate var failed: Bool = false

func runExample(_ runnable: SSRunnable) -> Bool {
  failed = false

  runnable()

  SSS.currentSession!.exampleInc()
  if (failed) {
    SSS.currentSession!.failureInc()
  }

  return !failed
}

public class SSExpect<T: Comparable> {
  public typealias ComparableType = T

  let value: ComparableType
  private var negate: Bool = false

  init(_ value: ComparableType) {
    self.value = value
  }

  public var to: SSExpect {
    return self
  }

  public var be: SSExpect {
    return self
  }

  public var not: SSExpect {
    negate = true
    return self
  }

  /// XXX should be in specialized comparator
  public func beTrue(_ value: Bool) {
    let compare = negate ? !value : value
    if !compare {
      failed = true
    }
  }

  /// XXX should be in specialized comparator
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


extension SSExpect where T == String {
  public func include(_ anotherString: String) {
    beTrue(value.range(of: anotherString) != nil)
  }
}

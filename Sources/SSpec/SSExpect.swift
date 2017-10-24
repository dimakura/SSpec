//
// SSpec
// SSExpect.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

fileprivate func toString(value: Any?) -> String {
  if let val = value { return String(describing: val) }
  return "nil"
}

/// Expectation.
public class SSExpect<T> {
  /// Main object.
  let value: T?

  var valueStr: String { return toString(value: value) }

  /// Negate relation.
  var negate: Bool = false

  /// Create expectation.
  init(_ value: T?) {
    self.value = value
  }

  /// Returns self: can be useful to build readable specs.
  public var to: SSExpect {
    return self
  }

  /// Returns self: can be useful to build readable specs.
  public var be: SSExpect {
    return self
  }

  /// Toggles negation flag. Two `not` statements restore negation.
  public var not: SSExpect {
    negate = !negate
    return self
  }

  /// Assert if given relation is true.
  func assert(_ value: Bool, error: String, errorNegate: String? = nil) {
    if negate && value {
      SSS.currentSession.fireExampleError(error: errorNegate ?? error)
    } else if !negate && !value {
      SSS.currentSession.fireExampleError(error: error)
    }
  }

  /// Asserts if given relation is false.
  // public func refute(_ value: Bool, error: String, errorNegate: String? = nil) {
  //   assert(!value, error: error, errorNegate: errorNegate ?? error)
  // }

  public var beNil: Void {
    assert(
      value == nil,
      error: "Expected `\(valueStr)` to be nil",
      errorNegate: "Expected `\(valueStr)` to NOT be nil"
    )
  }
}

/// Equality extension.
extension SSExpect where T: Equatable {
  public func eq(_ anotherValue: T?) {
    let anotherValueStr = toString(value: anotherValue)

    assert(
      value == anotherValue,
      error: "Expected \(valueStr) to equal \(anotherValueStr)",
      errorNegate: "Expected \(valueStr) to NOT equal \(anotherValueStr)"
    )
  }
}

// extension SSExpect where T: Comparable {
//   public func greaterThan(_ anotherValue: T) {
//     beTrue(value > anotherValue)
//   }
//
//   public func greaterOrEqualtThan(_ anotherValue: T) {
//     beTrue(value >= anotherValue)
//   }
//
//   public func lessThan(_ anotherValue: T) {
//     beTrue(value < anotherValue)
//   }
//
//   public func lessOrEqualThan(_ anotherValue: T) {
//     beTrue(value <= anotherValue)
//   }
// }

/// Extension for boolean values.
extension SSExpect where T == Bool {
  public var beTrue: Void {
    assert(
      value == true,
      error: "Expected \(valueStr) to be true",
      errorNegate: "Expected \(valueStr) to be false"
    )
  }

  public var beFalse: Void {
    assert(
      value == false,
      error: "Expected \(valueStr) to be false",
      errorNegate: "Expected \(valueStr) to be true"
    )
  }
}

// extension SSExpect where T == String {
//   public func include(_ anotherString: String) {
//     beTrue(value.range(of: anotherString) != nil)
//   }
// }

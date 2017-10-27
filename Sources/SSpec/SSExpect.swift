//
// SSpec
// SSExpect.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Convert given value to string.
fileprivate func toString(value: Any?) -> String {
  if let val = value { return String(describing: val) }
  return "nil"
}

/// Expectation.
public class SSExpect<T> {
  /// Value to compare.
  let value: T?

  /// Value represented as a string.
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
      SSS.currentSession.collectExampleError(error: errorNegate ?? error)
    } else if !negate && !value {
      SSS.currentSession.collectExampleError(error: error)
    }
  }

  public var beNil: Void {
    assert(
      value == nil,
      error: "Expected \(valueStr) to be nil",
      errorNegate: "Expected \(valueStr) to not be nil"
    )
  }
}

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

/// String extensions.
extension SSExpect where T == String {
  public func include(_ anotherString: String) {
    assert(
      value?.range(of: anotherString) != nil,
      error: "Expected \(valueStr) to include \(toString(value: anotherString))",
      errorNegate: "Expected \(valueStr) to not include \(toString(value :anotherString))"
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
      errorNegate: "Expected \(valueStr) to not equal \(anotherValueStr)"
    )
  }
}

/// Extension for arrays.
extension SSExpect where T == [Equatable] {
  private func areEqual<X: Equatable>(_ a: T?, _ b: [X]) -> Bool {
    guard let A = a as? [X] else { return false }
    return A == b
  }

  private func areSame<X: Comparable>(_ a: T?, _ b: [X]) -> Bool {
    guard let A = a as? [X] else { return false }
    return A.sorted { $0 < $1 } == b.sorted { $0 < $1 }
  }

  private func areInclusive<X: Equatable>(_ a: T?, _ b: [X]) -> Bool {
    guard let A = a as? [X] else { return false }

    for val in b {
      if !A.contains(val) {
        return false
      }
    }

    return true
  }

  public func eq<X: Equatable>(_ anotherValue: [X]) {
    let anotherValueStr = toString(value: anotherValue)

    assert(
      areEqual(value, anotherValue),
      error: "Expected \(valueStr) to equal \(anotherValueStr)",
      errorNegate: "Expected \(valueStr) to not equal \(anotherValueStr)"
    )
  }

  public func same<X: Comparable>(_ anotherValue: [X]) {
    let anotherValueStr = toString(value: anotherValue)

    assert(
      areSame(value, anotherValue),
      error: "Expected \(valueStr) to be the same as \(anotherValueStr)",
      errorNegate: "Expected \(valueStr) to not be the same as \(anotherValueStr)"
    )
  }

  public func include<X: Equatable>(_ anotherValue: [X]) {
    let anotherValueStr = toString(value: anotherValue)

    assert(
      areInclusive(value, anotherValue),
      error: "Expected \(valueStr) to include \(anotherValueStr)",
      errorNegate: "Expected \(valueStr) to not include \(anotherValueStr)"
    )
  }
}

// /// Comparable extension.
// extension SSExpect where T: Comparable {
//   public func greaterThan(_ anotherValue: T) {
//     // beTrue(value > anotherValue)
//   }
//
//   public func greaterOrEqualtThan(_ anotherValue: T) {
//     // beTrue(value >= anotherValue)
//   }
//
//   public func lessThan(_ anotherValue: T) {
//     // beTrue(value < anotherValue)
//   }
//
//   public func lessOrEqualThan(_ anotherValue: T) {
//     // beTrue(value <= anotherValue)
//   }
// }

/// Create expectation object.
public func expect<T>(_ value: T?) -> SSExpect<T> {
  return SSExpect<T>(value)
}

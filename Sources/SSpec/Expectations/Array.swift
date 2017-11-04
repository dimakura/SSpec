/// Expectations for generic arrays.
extension SSExpect where T == [Any] {
  private func isEmpty(_ a: T?) -> Bool {
    guard let A = a else { return false }
    return A.isEmpty
  }

  public var beEmpty: Void {
    assert(
      isEmpty(value),
      error: "Expected \(valueStr) to be empty",
      errorNegate: "Expected \(valueStr) to NOT be empty"
    )
  }
}

/// Expectations for equatable arrays.
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

  public func size(_ size: Int) {
    let count = value?.count ?? 0

    assert(
      count == size,
      error: "Expected \(valueStr) to have size \(size) but was \(count)",
      errorNegate: "Expected \(valueStr) to not have size \(size)"
    )
  }
}

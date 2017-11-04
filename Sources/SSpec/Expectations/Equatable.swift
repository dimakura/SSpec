/// Expectations for Equatable values.
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

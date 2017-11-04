/// Expectations for bool values.
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

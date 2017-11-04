/// Expectations for string values.
extension SSExpect where T == String {
  public func include(_ anotherString: String) {
    assert(
      value?.range(of: anotherString) != nil,
      error: "Expected \(valueStr) to include \(toString(value: anotherString))",
      errorNegate: "Expected \(valueStr) to not include \(toString(value :anotherString))"
    )
  }
}

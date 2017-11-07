import SSpec

private func isLong(_ value: [Int]?) -> Bool {
  guard let arr = value else { return false }
  return arr.count > 3
}

private func isShort(_ value: [Int]?) -> Bool {
  return !isLong(value)
}

extension SSExpect where T == [Int] {
  public var beLong: Void {
    assert(
      isLong(value),
      error: "Expected \(valueStr) to be long",
      errorNegate: "Expected \(valueStr) to be short"
    )
  }

  public var beShort: Void {
    assert(
      isShort(value),
      error: "Expected \(valueStr) to be long",
      errorNegate: "Expected \(valueStr) to be short"
    )
  }
}

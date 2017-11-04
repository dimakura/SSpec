/// Helper class for change.
public struct SSChange {
  let runnable: SSRunnable

  init(_ runnable: @escaping SSRunnable) {
    self.runnable = runnable
  }
}

/// Extension for change.
extension SSExpect where T == SSChange {
  private func inspectChange<E: Equatable>(_ expression: () -> E?) -> (E?, E?) {
    let initialValue = expression()
    self.value!.runnable()
    let finalValue = expression()

    let initialValueStr = toString(value: initialValue)
    let finalValueStr = toString(value: finalValue)

    assert(
      initialValue != finalValue,
      error: "Expected \(initialValueStr) to change but it doesn't",
      errorNegate: "Expected \(initialValueStr) to stay the same but changed to \(finalValueStr)"
    )
    return (initialValue, finalValue)
  }

  private func inspectValue<E: Equatable>(_ a: E? , _ b: E?) {
    let aStr = toString(value: a)
    let bStr = toString(value: b)

    assert(
      a == b,
      error: "Expected \(aStr) but was \(bStr)"
    )
  }

  private func assertNotNegate() {
    if negate {
      fatalError("You can use change matcher with negate only without parameters!")
    }
  }

  func change<E: Equatable>(_ expression: () -> E?) {
    _ = inspectChange(expression)
  }

  func change<E: Equatable>(from: E?, _ expression: () -> E?) {
    assertNotNegate()
    let (initialValue, _) = inspectChange(expression)
    inspectValue(from, initialValue)
  }

  func change<E: Equatable>(to: E?, _ expression: () -> E?) {
    assertNotNegate()
    let (_, finalValue) = inspectChange(expression)
    inspectValue(to, finalValue)
  }

  func change<E: Equatable>(from: E?, to: E?, _ expression: () -> E?) {
    assertNotNegate()
    let (initialValue, finalValue) = inspectChange(expression)
    inspectValue(from, initialValue)
    inspectValue(to, finalValue)
  }
}

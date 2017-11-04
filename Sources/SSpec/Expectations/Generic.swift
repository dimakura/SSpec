/// Base class and generic expectations.
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

  /// Returns self: can be useful to build readable specs.
  public var have: SSExpect {
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
      SSpec.currentSession.collectExampleError(error: errorNegate ?? error)
    } else if !negate && !value {
      SSpec.currentSession.collectExampleError(error: error)
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

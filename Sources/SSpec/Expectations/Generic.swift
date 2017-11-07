/// Base class and generic expectations.
public class SSExpect<T> {
  /// Value to compare.
  public let value: T?

  /// Value represented as a string.
  public var valueStr: String { return toString(value: value) }

  /// Negate relation.
  var negate: Bool = false

  /// Create expectation.
  init(_ value: T?) {
    self.value = value
  }

  /// Is this expectation negated?
  public var isNegate: Bool {
    return negate
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

  /// Toggles negation flag.
  public var not: SSExpect {
    negate = !negate
    return self
  }

  /// Assert if given relation is true.
  public func assert(_ value: Bool, error: String, errorNegate: String? = nil) {
    if isNegate && value {
      SSpec.currentSession.collectExampleError(error: errorNegate ?? error)
    } else if !isNegate && !value {
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

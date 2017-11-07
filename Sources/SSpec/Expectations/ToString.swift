/// Convert given value to string.
public func toString(value: Any?) -> String {
  if let val = value { return String(describing: val) }
  return "nil"
}

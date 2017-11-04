/// Version struct.
struct Version: CustomStringConvertible {
  let major: Int
  let minor: Int
  let patch: Int

  init(major: Int, minor: Int, patch: Int) {
    self.major = major
    self.minor = minor
    self.patch = patch
  }

  public var description: String {
    return "\(major).\(minor).\(patch)"
  }
}

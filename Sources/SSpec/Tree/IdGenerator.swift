/// Consequtive id generator.
struct IdGenerator {
  private static var lastId: Int = 0

  static var nextId: Int {
    lastId += 1
    return lastId
  }
}

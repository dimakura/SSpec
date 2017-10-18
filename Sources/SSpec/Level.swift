// Keeps track of current execution level.
fileprivate var level = 0


func currentLevel() -> Int {
  return level
}


func isLowestLevel() -> Bool {
  return level == 0
}


func levelDown(_ runnable: SSRunnable) {
  level += 1
  runnable()
  level -= 1
}

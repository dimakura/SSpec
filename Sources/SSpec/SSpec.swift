import Rainbow


/// Runnable type.
public typealias SSRunnable = () -> Void


/// Contextual run.
fileprivate func contextural(_ title: String, _ runnable: SSRunnable) {
  logWelcome()
  log(isLowestLevel() ?  " \(title) ".magenta.bold.onBlue : title.bold)
  levelDown(runnable)
  logGoodbye()
}


/// Context function.
public func SSContext(_ title: String, _ runnable: SSRunnable) {
  // TODO: don't invoke on top-level: use SSDescribe instead
  contextural(title, runnable)
}


/// Describe function.
public func SSDescribe(_ title: String, _ runnable: SSRunnable) {
  contextural(title, runnable)
}


/// Single test.
public func SSIt(_ title: String, _ runnable: () -> Void) {
  // TODO: monitor runnable to find failures
  try runnable()
  log("\u{2713} \(title)".green)
}

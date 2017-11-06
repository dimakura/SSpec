import Rainbow

/// Spec-style reporter.
class SpecReporter: Reporter {
  var level = -1 // We start from -1, so the first example will be 0

  override func onExampleSkipped(node: Example) {
    log("\u{2022} \(node.title)".yellow, level: level)
  }

  override func onContextStarted(node: Describe) {
    level += 1
    log(node.title.bold, level: level)
  }

  override func onContextEnded(node: Describe) {
    level -= 1
  }

  override func onExampleSuccess(node: Example) {
    log("\u{2714} \(node.title)".green, level: level)
  }

  override func onExampleFailure(node: Example) {
    log("\u{2717} \(node.title)".red, level: level)
  }
}

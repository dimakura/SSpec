import Rainbow

/// Spec-style reporter.
class SpecReporter: Reporter {
  override func onExampleSkipped(node: Example) {
    log("\u{2022} \(node.title)".yellow, level: node.level)
  }

  override func onContextStarted(node: Describe) {
    log(node.title.bold, level: node.level)
  }

  override func onExampleSuccess(node: Example) {
    log("\u{2714} \(node.title)".green, level: node.level)
  }

  override func onExampleFailure(node: Example) {
    log("\u{2717} \(node.title)".red, level: node.level)
  }
}

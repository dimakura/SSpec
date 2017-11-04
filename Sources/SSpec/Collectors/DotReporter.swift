import Rainbow

/// Dot-style reporter.
class DotReporter: Reporter {
  override func onExampleSkipped(node: Example) {
    print(".".yellow, terminator: "")
  }

  override func onExampleSuccess(node: Example) {
    print(".".green, terminator: "")
  }

  override func onExampleFailure(node: Example) {
    print(".".red, terminator: "")
  }

  override func onSpecEnded() {
    print()
  }
}

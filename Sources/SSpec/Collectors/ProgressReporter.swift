import Progress

/// Progress-style reporter.
class ProgressReporter: Reporter {
  var completedExampleCount: Int = 0
  var progressBar: ProgressBar?

  override func onSpecStarted() {
    progressBar = ProgressBar(count: totalExamples, configuration: [ProgressPercent(), ProgressBarLine(barLength: 40)])
  }

  override func onExampleSkipped(node: Example) {
    exampleDone()
  }

  override func onExampleSuccess(node: Example) {
    exampleDone()
  }

  override func onExampleFailure(node: Example) {
    exampleDone()
  }

  private func exampleDone() {
    completedExampleCount += 1
    progressBar!.setValue(completedExampleCount)
  }
}

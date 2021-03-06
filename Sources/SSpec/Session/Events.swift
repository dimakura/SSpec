/// Event relates extensions.
extension SSSession {
  /// Base class for collecting session related events.
  class Collector {
    func exampleRegistered(node: Example) {}
    func specStarted() {}
    func contextStarted(node: Describe) {}
    func exampleSkipped(node: Example) {}
    func exampleStarted(node: Example) {}
    func exampleError(error: String) {}
    func exampleEnded(node: Example) {}
    func contextEnded(node: Describe) {}
    func specEnded() {}
  }

  private func emitAll(_ emit: (Collector) -> Void) {
    for collector in self.collectors {
      emit(collector)
    }
  }

  func collectExampleRegistered(node: Example) {
    if node.focused { addFocused(node) }
    emitAll { collector in collector.exampleRegistered(node: node) }
  }

  func collectSpecStarted() {
    emitAll { collector in collector.specStarted() }
  }

  func collectContextStarted(node: Describe) {
    emitAll { collector in collector.contextStarted(node: node) }
  }

  func collectExampleSkipped(node: Example) {
    emitAll { collector in collector.exampleSkipped(node: node) }
  }

  func collectExampleStarted(node: Example) {
    incExamples()
    emitAll { collector in collector.exampleStarted(node: node) }
  }

  func collectExampleError(error: String) {
    markError()
    emitAll { collector in collector.exampleError(error: error) }
  }

  func collectExampleEnded(node: Example) {
    emitAll { collector in collector.exampleEnded(node: node) }
  }

  func collectContextEnded(node: Describe) {
    emitAll { collector in collector.contextEnded(node: node) }
  }

  func collectSpecEnded() {
    emitAll { collector in collector.specEnded() }
  }
}

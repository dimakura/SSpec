/// Example node.
class Example: Node {
  override func runInitialization() {
    SSpec.currentSession.collectExampleRegistered(node: self)
  }

  override func runTesting() {
    guard isCurrentNode else { return }

    if let run = runnable {
      SSpec.currentSession.collectExampleStarted(node: self)
      run()
      SSpec.currentSession.collectExampleEnded(node: self)
    } else {
      SSpec.currentSession.collectExampleSkipped(node: self)
    }
  }
}

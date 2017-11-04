/// Root node.
class Root: Node {
  override var isRoot: Bool { return true }

  override func runInitialization() {
    // skip
  }

  override func runTesting() {
    SSpec.currentSession.collectSpecStarted()
    runChildNodes()
    SSpec.currentSession.collectSpecEnded()
  }
}

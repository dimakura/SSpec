/// Root node.
class Root: Node {
  override var isRoot: Bool { return true }

  override func runTesting() {
    SSpec.currentSession.collectSpecStarted()
    runChildNodes()
    SSpec.currentSession.collectSpecEnded()
  }
}

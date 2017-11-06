/// Node which is generated by describe and context functions.
class Describe: Node {
  override func runInitialization() {
    guard let run = runnable else { return }
    run()
  }

  override func runTesting() {
    guard isFocused else { return }

    SSpec.currentSession.collectContextStarted(node: self)
    runChildNodes()
    SSpec.currentSession.collectContextEnded(node: self)
  }
}

/// After node.
class After: Node {
  override func runInitialization() {
    if let parent = self.parent {
      parent.postChildren.append(self)
    }
  }

  override func runTesting() {
    if isCurrentNode { return }
    if let run = runnable { run() }
  }
}

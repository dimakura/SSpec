/// Before node.
class Before: Node {
  override func runInitialization() {
    if let parent = self.parent {
      parent.preChildren.append(self)
    }
  }

  override func runTesting() {
    if isCurrentNode { return }
    if let run = runnable { run() }
  }
}

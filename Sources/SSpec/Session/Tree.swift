extension SSSession {
  /// Build description node/
  func describe(_ title: String, _ runnable: SSRunnable?) {
    buildTree {
      return Describe(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  /// Build example node.
  func it(_ title: String, _ runnable: SSRunnable?) {
    buildTree {
      return Example(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  private func buildTree(_ createNode: () -> Node) {
    guard self.mode == .Initializing else { return }

    let parentNode = _currentNode
    let newNode = createNode()

    _currentNode = newNode
    _currentNode.runInitial()
    _currentNode = parentNode
  }
}
//
// SSpec
// Example.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Example node.
class Example: Node {
  override init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    super.init(title: title, parent: parent, runnable: runnable)
    if let par = parent { par.children.append(self) }
  }

  override func runInitial() {
    // skip
  }

  override func runExamples() {
    guard canRunExample() else { return }

    if let run = runnable {
      SSpec.currentSession.collectExampleStarted(node: self)
      run()
      SSpec.currentSession.collectExampleEnded(node: self)
    } else {
      SSpec.currentSession.collectExampleSkipped(node: self)
    }
  }

  private func canRunExample() -> Bool {
    if self.id == Node.currentId { return true }
    if let parent = self.parent, parent.isRoot { return true }

    return false
  }
}

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
  override func runInitialization() {
    SSpec.currentSession.collectExampleRegistered(node: self)
  }

  override func runTesting() {
    guard isCurrentNode() else { return }

    if let run = runnable {
      SSpec.currentSession.collectExampleStarted(node: self)
      run()
      SSpec.currentSession.collectExampleEnded(node: self)
    } else {
      SSpec.currentSession.collectExampleSkipped(node: self)
    }
  }
}

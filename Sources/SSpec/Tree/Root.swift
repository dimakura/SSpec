//
// SSpec
// Root.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

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

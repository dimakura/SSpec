//
// SSpec
// Before.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Before node.
class Before: Node {
  override func runInitialization() {
    if let parent = self.parent {
      parent.preChildren.append(self)
    }
  }

  override func runTesting() {
    if isCurrentNode() { return }
    if let run = runnable { run() }
  }
}

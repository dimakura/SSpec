//
// SSpec
// Tree.swift
//
// Created by Dimitri Kurashvili on 2017-11-01
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

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

  /// Build before node.
  func before(_ runnable: SSRunnable?) {
    buildTree {
      return Before(title: "Before", parent: _currentNode, runnable: runnable)
    }
  }

  func after(_ runnable: SSRunnable?) {
    buildTree {
      return After(title: "After", parent: _currentNode, runnable: runnable)
    }
  }

  private func buildTree(_ createNode: () -> Node) {
    guard self.mode == .Initializing else { return }

    let parentNode = _currentNode
    let newNode = createNode()

    _currentNode = newNode
    _currentNode.runInitialization()
    _currentNode = parentNode
  }
}

//
// SSpec
// SSMatcher.swift
//
// Created by Dimitri Kurashvili on 2017-10-22
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Runnable type.
public typealias SSRunnable = () -> Void
public typealias MatcherFunction = (String, SSRunnable?) -> Void

/// Matching interface.
public class SSMatcher {
  private var _currentNode: Node

  init() {
    _currentNode = RootNode(title: "ROOT")
  }

  func execInitMode(_ runnable: SSRunnable) {
    runnable()
  }

  func execRunMode(_ runnable: SSRunnable) {
    _currentNode.runExamples()
  }

  func describe(_ title: String, _ runnable: SSRunnable? = nil) {
    buildTree {
      return DescribeNode(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  func it(_ title: String, _ runnable: SSRunnable? = nil) {
    buildTree {
      return ExampleNode(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  private func buildTree(_ createNode: () -> Node) {
    guard SSS.currentSession.mode == .Initializing else { return }

    let parentNode = _currentNode
    let newNode = createNode()

    _currentNode = newNode
    _currentNode.runInitial()
    _currentNode = parentNode
  }
}

public var describe: MatcherFunction { return SSS.currentSession.matcher.describe }
public var context: MatcherFunction { return SSS.currentSession.matcher.describe }
public var it: MatcherFunction { return SSS.currentSession.matcher.it }

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

/// Matching interface.
public class SSMatcher {
  private var _currentNode: Node

  init() {
    _currentNode = RootNode(title: "ROOT")
  }

  func execInitMode(_ runnable: (SSMatcher) -> Void) {
    runnable(self)
  }

  func execRunMode(_ runnable: (SSMatcher) -> Void) {
    _currentNode.runExamples()
  }

  public func describe(_ title: String, _ runnable: SSRunnable? = nil) {
    buildTree {
      return DescribeNode(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  public func context(_ title: String, _ runnable: SSRunnable? = nil) {
    describe(title, runnable)
  }

  public func it(_ title: String, _ runnable: SSRunnable? = nil) {
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

extension SSMatcher {
  public func expect<Bool>(_ value: Bool) -> SSExpect<Bool> {
    return SSExpect<Bool>(value)
  }
}

extension SSMatcher {
  func expect(_ value: Int?) -> SSExpect<Int> {
    return SSExpect<Int>(value)
  }

  public func expect(_ value: Float?) -> SSExpect<Float> {
    return SSExpect<Float>(value)
  }

  public func expect(_ value: Double?) -> SSExpect<Double> {
    return SSExpect<Double>(value)
  }

  public func expect(_ value: String?) -> SSExpect<String> {
    return SSExpect<String>(value)
  }
}

//
// SSpec
// SSMatcher.swift
//
// Created by Dimitri Kurashvili on 2017-10-22
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

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

  private func buildTree(_ runnable: () -> Node) {
    guard SSS.currentSession?.mode == .Initializing else { return }

    let prevNode = _currentNode
    let newNode = runnable()

    _currentNode = newNode
    _currentNode.runInitial()
    _currentNode = prevNode
  }

  public func describe(_ title: String, _ runnable: SSRunnable? = nil) {
    buildTree {
      return DescribeNode(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  public func it(_ title: String, _ runnable: SSRunnable? = nil) {
    buildTree {
      return ExampleNode(title: title, parent: _currentNode, runnable: runnable)
    }
  }

  public func expect(_ value: Int) -> SSExpect<Int> {
    return SSExpect<Int>(value)
  }

  public func expect(_ value: Float) -> SSExpect<Float> {
    return SSExpect<Float>(value)
  }

  public func expect(_ value: Double) -> SSExpect<Double> {
    return SSExpect<Double>(value)
  }

  public func expect(_ value: String) -> SSExpect<String> {
    return SSExpect<String>(value)
  }
}

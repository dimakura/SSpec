//
// SSpec
// Node.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

fileprivate struct IdGenerator {
  private static var lastId: Int = 0

  static var nextId: Int {
    lastId += 1
    return lastId
  }
}

/// Node of specs tree.
class Node {
  /// When we run spec, we store id of the current example in this variable.
  static var currentId: Int = -1

  /// Unique identificator of this node.
  let id: Int

  /// Parent node.
  let parent: Node?

  /// Level starts with `-1` for root node and goes up each new level.
  let level: Int

  /// Description of the node.
  let title: String

  /// Executable for this node.
  let runnable: SSRunnable?

  /// Child nodes.
  var children: [Node]

  /// Creates node.
  init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    self.id = IdGenerator.nextId
    self.parent = parent
    self.level = (parent?.level ?? -2) + 1
    self.title = title
    self.runnable = runnable
    self.children = [Node]()
  }

  func runInitial() {
    fatalError("Each subclass should implement #runInitial.")
  }

  func runExamples() {
    fatalError("Each subclass should implement #runExamples.")
  }

  var fullTitle: String {
    if let par = parent {
      let parentTitle = par.fullTitle
      return parentTitle == "ROOT" ? title : "\(par.fullTitle) \(title)"
    }
    return title
  }
}

/// Root node of specs tree.
class RootNode: Node {
  override func runInitial() {
    // skip
  }

  override func runExamples() {
    SSS.currentSession.fireSpecStarted()

    for child in children {
      child.runExamples()
    }

    SSS.currentSession.fireSpecEnded()
  }
}

/// Node which corresponds to Describe and Context.
class DescribeNode: Node {
  override init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    super.init(title: title, parent: parent, runnable: runnable)

    if let parent = self.parent {
      parent.children.append(self)
    }
  }

  override func runInitial() {
    guard let run = runnable else { return }
    run()
  }

  override func runExamples() {
    guard let run = runnable else { return }

    SSS.currentSession.fireContextStarted(node: self)

    for child in children {
      Node.currentId = child.id
      run()
      child.runExamples()
    }

    SSS.currentSession.fireContextEnded(node: self)
  }
}

/// Example node.
class ExampleNode: Node {
  override init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    super.init(title: title, parent: parent, runnable: runnable)
    if let par = parent { par.children.append(self) }
  }

  override func runInitial() {
    // skip
  }

  override func runExamples() {
    guard self.id == Node.currentId else { return }

    if let run = runnable {
      SSS.currentSession.fireExampleStarted(node: self)
      run()
      SSS.currentSession.fireExampleEnded(node: self)
    } else {
      SSS.currentSession.fireExampleSkipped(node: self)
    }
  }
}

//
// SSpec
// Node.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Execution node for specs tree.
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

  /// Is this a root node?
  var isRoot: Bool { return false }

  /// Child nodes.
  var children: [Node]

  /// Children which are run before everything else.
  var preChildren: [Node]

  /// Children which are run after everything else.
  var postChildren: [Node]

  /// Creates node.
  init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    self.id = IdGenerator.nextId
    self.parent = parent
    self.level = (parent?.level ?? -2) + 1
    self.title = title
    self.runnable = runnable
    self.children = [Node]()
    self.preChildren = [Node]()
    self.postChildren = [Node]()

    if let par = parent { par.children.append(self) }
  }

  /// Execute some code in some id's context.
  func withId(_ id: Int? = nil, _ runnable: SSRunnable?) {
    let previoudId = Node.currentId
    Node.currentId = id ?? self.id
    if let run = runnable {
      run()
    }
    Node.currentId = previoudId
  }

  /// If this node is current one?
  func isCurrentNode() -> Bool {
    return self.id == Node.currentId
  }

  /// Full title of the node.
  var fullTitle: String {
    if let parent = self.parent {
      return parent.isRoot ? title : "\(parent.fullTitle) \(title)"
    }
    return title
  }

  /// This method runs during initialization.
  func runInitialization() {}

  /// This method runs during test mode.
  func runTesting() {}

  /// Standard code for executing child nodes.
  func runChildNodes() {
    func runPres() {
      for pre in self.preChildren {
        pre.runTesting()
      }
    }

    func runPosts() {
      for post in self.postChildren {
        post.runTesting()
      }
    }

    for child in self.children {
      withId(child.id) {
        runPres()
        child.runTesting()
        runPosts()
      }
    }
  }
}

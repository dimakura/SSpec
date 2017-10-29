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
    if let parent = self.parent {
      return parent.isRoot ? title : "\(parent.fullTitle) \(title)"
    }
    return title
  }
}

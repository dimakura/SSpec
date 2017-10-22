//
// SSpec
// Node.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//
import Rainbow

class Node {
  static var currentId: Int = -1

  private static var lastId: Int = 0
  private static var nextId: Int {
    lastId += 1
    return lastId
  }

  /// Level starts with `-1` for root node and goes up each new level.
  let level: Int

  /// Unique identificator of this node.
  let id: Int

  /// Parent node.
  let parent: Node?

  /// Description of the node.
  let title: String

  /// Executable for this node.
  let runnable: SSRunnable?

  /// Child nodes.
  var children: [Node]

  init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    self.id = Node.nextId
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
}

class RootNode: Node {
  override func runInitial() {
    // skip
  }

  override func runExamples() {
    for child in children {
      child.runExamples()
    }
  }
}

class DescribeNode: Node {
  override init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    super.init(title: title, parent: parent, runnable: runnable)
    if let par = parent { par.children.append(self) }
  }

  override func runInitial() {
    guard let run = runnable else { return }
    run()
  }

  override func runExamples() {
    guard let run = runnable else { return }

    log(title.bold, level: level)

    for child in children {
      Node.currentId = child.id
      run()
      child.runExamples()
    }
  }
}

class ExampleNode: Node {
  override init(title: String, parent: Node? = nil, runnable: SSRunnable? = nil) {
    super.init(title: title, parent: parent, runnable: runnable)
    if let par = parent { par.children.append(self) }
  }

  override func runInitial() {
    // skip
  }

  override func runExamples() {
    guard let run = runnable else { return }

    if (self.id == Node.currentId) {
      let result = runExample(run)
      if result {
        log("\u{2714} \(title)".green, level: level)
      } else {
        log("\u{2717} \(title)".red, level: level)
      }
    }
  }
}

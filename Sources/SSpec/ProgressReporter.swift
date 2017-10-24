//
// SSpec
// ProgressReporter.swift
//
// Created by Dimitri Kurashvili on 2017-10-24
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Rainbow

/// Progress reporter.
class ProgressReporter: SSSessionListenerAdapter {
  private var exampleFailures: Int = 0
  private var currentExample: ExampleNode?
  private var exampleTitles = [Int: String]()
  private var errorsByExample = [Int: [String]]()

  var examples: Int = 0
  var skipes:   Int = 0
  var failures: Int { return errorsByExample.count }

  override func contextStarted(node: DescribeNode) {
    log(node.title.bold, level: node.level)
  }

  override func exampleSkipped(node: ExampleNode) {
    skipes += 1
    log("\u{2022} \(node.title)".yellow, level: node.level)
  }

  override func exampleStarted(node: ExampleNode) {
    examples += 1
    currentExample = node
    exampleFailures = 0
  }

  override func exampleError(error: String) {
    guard let example = currentExample else { return }

    exampleFailures += 1

    if var errors = errorsByExample[example.id] {
      errors.append(error)
      errorsByExample[example.id] = errors
    } else {
      errorsByExample[example.id] = [error]
      exampleTitles[example.id] = example.fullTitle
    }
  }

  override func exampleEnded(node: ExampleNode) {
    if exampleFailures > 0 {
      log("\u{2717} \(node.title)".red, level: node.level)
    } else {
      log("\u{2714} \(node.title)".green, level: node.level)
    }
    currentExample = nil
  }

  override func specEnded() {
    logErrors()
    logSummary()
  }

  private func log(_ text: String, level: Int = 0) {
    let indent = String(repeating: " ", count: 2 * level)
    print("\(indent)\(text)")
  }

  private var wasSkipped: Bool {
    return skipes > 0
  }

  private var failed: Bool {
    return failures > 0
  }

  private var wasClean : Bool {
    return !wasSkipped && !failed
  }

  private func logErrors() {
    guard failed else { return }

    print("Failures summary:")

    var exampleNumber = 0
    for (id, errors) in errorsByExample {
      exampleNumber += 1
      print()
      log("\(exampleNumber). \(exampleTitles[id]!):".bold, level: 1)
      if errors.count == 1 {
        log(errors.first!.red, level: 2)
      } else {
        var subExampleNumber = 0
        for error in errors {
          subExampleNumber += 1
          log("\(exampleNumber).\(subExampleNumber)) " + error.red, level: 2)
        }
      }
    }
  }

  private func logSummary() {
    var summary: String = "\(examples) example(s)"
    if wasSkipped { summary += ", " + "\(skipes) skipped".yellow.bold }
    if failed { summary += ", " + "\(failures) failure(s)".red.bold }
    if wasClean { summary += " OK".green }
    print("\nSummary: \(summary)")
  }
}

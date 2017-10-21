//
// SSpec
// Log.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//


/// Log text with indents corresponding to current level.
func log(_ text: String) {
  let indent = String(repeating: " ", count: 2 * currentLevel())
  print("\(indent)\(text)")
}

/// Welcome messaging.
func logWelcome() {
  if isLowestLevel() {
    print("\n-- SSpec 0.1.0\n")
  }
}

/// Report on goodbuy.
func logGoodbye() {
  if isLowestLevel() {
    var summary: String = "\(examplesCount) example(s)"

    if failuresCount > 0 {
      summary += ", " + "\(failuresCount) failure(s)".red.bold
    } else {
      summary += " OK".green
    }

    print("\nSummary: \(summary)")
    print("\n-- Bye!\n")
  }
}

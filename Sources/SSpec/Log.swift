//
// SSpec
// Log.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//
import Rainbow

func log(_ text: String, level: Int = 0) {
  let indent = String(repeating: " ", count: 2 * level)
  print("\(indent)\(text)")
}

/// Report on goodbuy.
func logGoodbye() {
  let session = SSS.currentSession!
  var summary: String = "\(session.exampleCount) example(s)"

  if session.failureCount > 0 {
    summary += ", " + "\(session.failureCount) failure(s)".red.bold
  } else {
    summary += " OK".green
  }

  print("\nSummary: \(summary)")
  print("\n-- Bye!\n")
}

//
// SSpec
// SSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Rainbow


/// Contextual run.
fileprivate func contextural(_ title: String, _ runnable: SSRunnable) {
  log(isLowestLevel() ?  " \(title) ".magenta.bold.onBlue : title.bold)
  levelDown(runnable)
}


/// Context function.
public func context(_ title: String, _ runnable: SSRunnable) {
  // TODO: don't invoke on top-level: use SSDescribe instead
  contextural(title, runnable)
}


/// Describe function.
public func describe(_ title: String, _ runnable: SSRunnable) {
  contextural(title, runnable)
}


/// Single test.
public func it(_ title: String, _ runnable: SSRunnable) {
  if runExample(runnable) {
    log("\u{2713} \(title)".green)
  } else {
    log("\u{2717} \(title)".red)
  }
}


// Expectation factories

public func expect(_ value: Int) -> SSpecExpect<Int> {
  return SSpecExpect<Int>(value)
}

public func expect(_ value: Float) -> SSpecExpect<Float> {
  return SSpecExpect<Float>(value)
}

public func expect(_ value: Double) -> SSpecExpect<Double> {
  return SSpecExpect<Double>(value)
}

public func expect(_ value: String) -> SSpecExpect<String> {
  return SSpecExpect<String>(value)
}

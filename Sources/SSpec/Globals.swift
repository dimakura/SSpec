//
// SSpec
// Root.swift
//
// Created by Dimitri Kurashvili on 2017-11-01
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Describe function.
public func describe(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Context function.
public func context(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Before hook.
public func before(_ runnable: SSRunnable?) {
  SSpec.currentSession.before(runnable)
}

/// Example function.
public func it(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.it(title, runnable)
}

/// After hook.
public func after(_ runnable: SSRunnable?) {
  SSpec.currentSession.after(runnable)
}

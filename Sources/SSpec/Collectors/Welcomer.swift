//
// SSpec
// Welcomer.swift
//
// Created by Dimitri Kurashvili on 2017-10-25
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// This collector displays welcome message when session starts.
class Welcomer: SSSession.Collector {
  override func specStarted() {
    print("\n-- Runing SSpec v\(Version.currentVersion)\n")
  }
}

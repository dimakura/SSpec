//
// SSpec
// Version.swift
//
// Created by Dimitri Kurashvili on 2017-10-21
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

struct Version: CustomStringConvertible {
  static let currentVersion: Version = Version(major: 0, minor: 1, patch: 2)

  let major: Int
  let minor: Int
  let patch: Int

  init(major: Int, minor: Int, patch: Int) {
    self.major = major
    self.minor = minor
    self.patch = patch
  }

  public var description: String {
    return "\(major).\(minor).\(patch)"
  }
}

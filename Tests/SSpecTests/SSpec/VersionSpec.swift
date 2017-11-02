//
// SSpec
// VersionSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-24
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

@testable import SSpec

func versionSpecs() {
  let expectedVersion = "0.2.0"

  describe("Latest version") {
    let v = Version.currentVersion

    it("is \(expectedVersion)") {
      expect(v.description).to.eq(expectedVersion)
    }
  }
}

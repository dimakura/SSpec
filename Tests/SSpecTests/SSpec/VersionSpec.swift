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
  describe("Version") {
    let v = Version.currentVersion

    it("is 0.1.3") {
      expect(v.description).to.eq("0.1.3")
    }
  }
}

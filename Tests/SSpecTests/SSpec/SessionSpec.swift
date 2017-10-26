//
// SSpec
// SessionSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-24
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

@testable import SSpec

func sessionSpecs() {
  context("Session") {
    let s = SSS.currentSession

    it("is running") {
      expect(s.mode).to.eq(SSS.Mode.Running)
    }

    it("has a matcher") {
      expect(s.matcher).to.not.beNil
    }
  }
}

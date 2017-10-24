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
    // This session is the same as the one we are currently running.
    let s = SSS.currentSession

    it("should be in running mode") {
      expect(s.mode).to.eq(SessionMode.Running)
    }

    it("should have matcher") {
      expect(s.matcher).to.not.beNil
    }
  }
}

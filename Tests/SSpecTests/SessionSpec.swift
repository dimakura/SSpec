//
// SSpec
// SessionSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-24
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

@testable import SSpec

func sessionSpecs(_ spec: SSMatcher) {
  spec.describe("Session") {
    // This session is the same as the one we are currently running.
    let s = SSS.currentSession

    // XXX: this usage is not visible in report
    //      we should probably not allow it
    //      expect should be only available in examples
    // spec.expect(s.mode).to.not.eq(SessionMode.Initializing)

    spec.it("has the same matcher") {
      spec.expect(s.matcher === spec).to.beTrue
    }

    spec.it("should be in running mode") {
      spec.expect(s.mode).to.eq(SessionMode.Running)
    }
  }
}

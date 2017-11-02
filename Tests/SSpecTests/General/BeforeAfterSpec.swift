//
// SSpec
// BeforeAfterSpec.swift
//
// Created by Dimitri Kurashvili on 2017-11-01
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import SSpec

func beforeSpecs() {
  describe("Before") {
    var a = 100

    before {
      a = 5
    }

    it("is 5") {
      expect(a).to.eq(5)
      a = 200
    }

    it("is still 5") {
      expect(a).to.eq(5)
      a = 500
    }
  }
}

func afterSpecs() {
  describe("After") {
    var a = 100

    it("is 100") {
      expect(a).to.eq(100)
      a = 300
    }

    it("is still 100") {
      expect(a).to.eq(100)
      a = 200
    }

    after {
      a = 100
    }
  }
}

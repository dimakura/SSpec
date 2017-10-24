//
// SSpec
// GneralSpecs.swift
//
// Created by Dimitri Kurashvili on 2017-10-24
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

@testable import SSpec

func nilableSpecs() {
  context("Nilable") {
    it("is nil") {
      let nilValue: String? = nil
      expect(nilValue).to.beNil
    }

    it("is not nil") {
      expect("Some string").to.not.beNil
    }
  }
}

func booleanSpecs() {
  context("Bool") {
    it("is true") {
      expect(true).to.beTrue
    }

    it("is false") {
      expect(false).to.beFalse
    }
  }
}

func stringSpecs() {
  context("String") {
    it("contains another string") {
      expect("Swift is awesome!").to.include("awesome")
    }

    it("does not contain another string") {
      expect("Swift is awesome!").to.not.include("ugly")
    }
  }
}

func equatableSpecs() {
  context("Equatable") {
    it("1 == 1") {
      expect(1).to.eq(1)
    }

    it("1 != 2") {
      expect(1).to.not.eq(2)
    }
  }
}

func generalSpecs() {
  describe("General specs") {
    nilableSpecs()
    booleanSpecs()
    stringSpecs()
    equatableSpecs()
  }
}

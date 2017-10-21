//
// SSpec
// SSpecTests.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import XCTest
import SSpec

func arithmetics() {
  describe("Arithmetic") {
    let a = 10
    let b = 5

    context("Multiplication and Division") {
      it("10 * 5 = 50") {
        expect(a / b).to.eq(2)
      }

      it("10 / 5 = 2") {
        expect(a / b).to.eq(2)
      }
    }

    context("Addition and Subtraction") {
      it("10 + 5 = 15") {
        expect(a + b).to.eq(15)
      }

      it("10 - 5 = 5") {
        expect(a - b).to.eq(5)
      }
    }

    context("Comparison") {
      it("10 > 5") {
        expect(a).to.be.greaterThan(b)
      }

      it("5 < 10") {
        expect(b).to.be.lessThan(a)
      }

      it("10 != 5") {
        expect(a).not.to.eq(b)
      }
    }
  }
}

func strings() {
  describe("Strings") {
    let a = "Swift is awesome"
    let b = "awe"

    it("'\(a)' includes '\(b)'") {
      expect(a).to.include(b)
    }

    it("'\(a)' doesn't include 'ugly'") {
      expect(a).to.not.include("zero")
    }
  }
}

class SSpecTests: XCTestCase {
  func testExample() {
    let resp = SSRun() {
      arithmetics()
      strings()
    }
    XCTAssert(resp, "Some specs are failing.")
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}

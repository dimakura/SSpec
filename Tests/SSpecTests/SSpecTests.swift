//
// SSpec
// SSpecTests.swift
//
// Created by Dimitri Kurashvili on 2017-10-20
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import XCTest
@testable import SSpec

class SSpecTests: XCTestCase {
  func testSimpleRuns() {
    SSpec.run {
      it("wrong math") { expect(2 + 2).to.eq(5) }
    }
    XCTAssert(SSpec.exampleCount == 1)
    XCTAssert(SSpec.hasErrors == true)

    SSpec.run {
      it("correct math") { expect(2 + 2).to.eq(4) }
    }
    XCTAssert(SSpec.exampleCount == 1)
    XCTAssert(SSpec.hasErrors == false)

    SSpec.run {
      describe("Arithmetics") {
        context("addition") {
          it("2 + 2 = 4") {
            expect(2 + 2).to.eq(4)
          }
        }
        context("multiplication") {
          it("2 * 2 = 4") {
            expect(2 * 2).to.eq(4)
          }
        }
      }
    }
    XCTAssert(SSpec.exampleCount == 2)
    XCTAssert(SSpec.hasErrors == false)
  }

  func testSpecs() {
    SSpec.run {
      describe("SSpec") {
        versionSpecs()
        sessionSpecs()
      }
      describe("General specs") {
        nilableSpecs()
        booleanSpecs()
        stringSpecs()
        equatableSpecs()
        arraySpecs()
      }
    }

    XCTAssert(SSpec.hasErrors == false)
  }

  static var allTests = [
    ("testSimpleRuns", testSimpleRuns),
    ("testSpecs", testSpecs),
  ]
}

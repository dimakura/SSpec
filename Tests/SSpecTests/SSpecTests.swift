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
  func testSimpleSessions() {
    let s1 = SSS.run {
      it("wrong math") { expect(2 + 2).to.eq(5) }
    }
    XCTAssert(s1.exampleCount == 1)
    XCTAssert(s1.hasErrors == true)

    let s2 = SSS.run {
      it("correct math") { expect(2 + 2).to.eq(4) }
    }
    XCTAssert(s2.exampleCount == 1)
    XCTAssert(s2.hasErrors == false)

    let s3 = SSS.run {
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
    XCTAssert(s3.exampleCount == 2)
    XCTAssert(s3.hasErrors == false)
  }

  func testSpecs() {
    let session = SSS.run {
      describe("SSpec") {
        versionSpecs()
        sessionSpecs()
      }
      describe("General specs") {
        nilableSpecs()
        booleanSpecs()
        stringSpecs()
        equatableSpecs()
      }
    }

    XCTAssert(session.hasErrors == false)
  }

  static var allTests = [
    ("testSimpleSessions", testSimpleSessions),
    ("testSpecs", testSpecs),
  ]
}

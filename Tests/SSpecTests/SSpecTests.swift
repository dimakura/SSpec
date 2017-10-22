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

func testSpecs(_ spec: SSMatcher) {
  spec.describe("Arithmetics") {
    let a = 5
    let b = 3

    spec.it("5 + 3 == 8") {
      spec.expect(a + b).to.eq(8)
    }

    spec.it("5 - 3 != 3") {
      spec.expect(a - b).to.not.eq(3)
    }
  }
}

class SSpecTests: XCTestCase {
  func testExample() {
    let resp = SSS.run({ spec in
      testSpecs(spec)
    })

    XCTAssert(resp, "Some specs are failing.")
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}

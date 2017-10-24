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

class SSpecTests: XCTestCase {
  func testExample() {
    let resp = SSS.run({ spec in
      versionSpecs(spec)
      sessionSpecs(spec)
    })

    XCTAssert(resp, "Some specs are failing: see output above.")
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}

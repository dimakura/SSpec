# SSpec

`SSpec` offers nice alternative to standard `XCTest` for Swift developers.
Instead of writing test as sequence of assertions you can organize it in
easily testable and documented steps.

If you worked with behavior driven development (BDD) before
you will find `SSpec` to be already familiar. For those new to BDD, it's
still easy to get started and worth spending some time to understand it.

[![Build Status](https://travis-ci.org/dimakura/SSpec.svg?branch=master)](https://travis-ci.org/dimakura/SSpec)

## Installation

Add the following dependency in your `Package.swift` config:

```swift
.package(url: "https://github.com/dimakura/SSpec", from: "0.1.0")
```

And don't forget to add it as dependency in your test target:

```swift
.testTarget(
  name: "MyPackageTests",
  dependencies: [
    "SSpec",
    // your other dependencies
  ]),
```

Package will be configured by swift package manager after:

```sh
swift build
```

## Usage

A minimal usage example is given below:

```swift
import XCTest
import SSpec                       // import SSpec package
@testable import MyPackage         // import your package as usual

func theTruth(_ spec: SSMatcher) { // SSMatcher provides `it`, `describe`, `expect` etc. methods
  spec.it("Ground truth") {        // Example
    spec.expect(true).to.beTrue()  // tests that `true` is `true` indeed
  }
}

class MyPackageTests: XCTestCase {   // To bootstrap `SSpec` we still use `XCTest`
                                     // to easily integrate with existing tools

  func testEverything() {            // This is the only test you need to define
    let resp = SSS.run { spec in     // `resp` is Bool
      theTruth(spec)                 // You call the function we defined above
      // more functions can be called
    }

    XCTAssert(resp, "Some specs are failing.") // Report `resp` to have nice integration with CIs
  }

  static var allTests = [
    ("testEverything", testEverything),
  ]
}
```

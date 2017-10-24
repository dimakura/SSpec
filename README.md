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

Let's consider simplest example:

```swift
let session = SSS.run {
  it("correct math") {
    expect(2 + 2).to.eq(4)
  }
}

XCTAssert(session.hasErrors == false)
```

It contains single example ("correct math") which is run inside `SSS.run { ... }`.

Note the last line in this example:

```swift
XCTAssert(session.hasErrors == false)
```

This line is not strictly necessary but in case your
CI infrastructure relies on XCTest's failure this will help.

You will see nice output after running example above:

![Simple Example Output](https://s1.postimg.org/3yxge26htb/Screen_Shot_2017-10-24_at_9.23.22_PM.png)

## Describe and context

TODO:

## Matchers

TODO:

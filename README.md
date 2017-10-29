# SSpec

SSpec is a behavior driven development (BDD) framework for Swift developers and
it offers awesome alternative to standard XCTest.

If you worked with behavior driven development (BDD) before SSpec should be
already familiar to you. And it's simple to understand and get started for those
who never worked with any BDD frameworks before.

[![Build Status](https://travis-ci.org/dimakura/SSpec.svg?branch=master)](https://travis-ci.org/dimakura/SSpec)

## Installation

Add SSpec as package dependency in your project's `Package.swift` file:

```swift
.package(url: "https://github.com/dimakura/SSpec", from: "0.1.2")
```

You should also put it under test target's dependencies:

```swift
.testTarget(
  name: "MyPackageTests",
  dependencies: [
    "SSpec",
    // other dependencies
  ]),
```

Package manager downloads SSpec for you during build:

```sh
swift build
```

To use SSpec in your code, just import it:

```swift
import SSpec
```

## Simple example

You can easily understand a lot about SSpec looking at this simple example:

```swift
SSpec.run {                   // 1
  it("2 + 2 = 4") {           // 2
    expect(2 + 2).to.eq(4)    // 3
  }
}

XCTAssert(SSpec.hasErrors == false)
```

Standard way to run SSpec is to use `SSpec.run` method as this is done at the
first line of our example. Inside closure for this method we define our test
examples.

The first (and only) test example is defined on the second line.
It has title (`"2 + 2 = 4"`) and one more closure.

Inside test example's closure at line three, you can see what this example
actually tries to test. It makes sure that `2 + 2` is indeed equal to `4`.

You can place as many examples inside body of `SSpec.run {...}` as needed.
SSpec runs all of the examples and checks their correctness.

In case of our simple example output from running tests looks like this:

![Simple Example Output](https://s1.postimg.org/3yxge26htb/Screen_Shot_2017-10-24_at_9.23.22_PM.png)

If any of the example fails, SSpec will print detailed report of what went
wrong, so you can easily locate source of the problem.

To detect failures programmatically, you can use `SSpec.hasErrors` property,
which is `false` by default, but becomes `true` once there's at least one
example failing in your specs.

You can use this property to report failure back to `XCTest`:

```swift
XCTAssert(SSpec.hasErrors == false)
```

This is not strictly necessary. But in cases when your CI relies on XCTest's
failure, it's a handy way to detect errors.

## Describe and context

TODO:

## Matchers

TODO:

## Contributing

If you are interested in contributing to SSpec please [read about it here](./CONTRIBUTING.md).

# SSpec

`SSpec` offers awesome alternative to `XCTest` for Swift developers.

Instead of writing tests as a sequence of assertions you can organize them in small, easily readable steps.

If you worked with behavior driven development (BDD) before, `SSpec` is already familiar to you.
And it's simple to understand for those of you who never worked with BDD framework before.

[![Build Status](https://travis-ci.org/dimakura/SSpec.svg?branch=master)](https://travis-ci.org/dimakura/SSpec)

## Installation

Add `SSpec` as package dependency in your project's `Package.swift` file:

```swift
.package(url: "https://github.com/dimakura/SSpec", from: "0.1.0")
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

`SSpec` will be downloaded and installed by Swift package manager after building your project:

```sh
swift build
```

And finally import `SSpec` to use it in your code:

```swift
import SSpec
```

## Simple example

This is our first example:

```swift
let session = SSSession.run {    // 1
  it("correct math") {           // 2
    expect(2 + 2).to.eq(4)       // 3
  }
}

XCTAssert(session.hasErrors == false)
```

At first line we create session with call to static `SSSession.run` method.
Inside closure for this method we define our test examples.

The first (and only) test example is defined on the second line.
It has title ("correct math") and one more closure.

Inside test example's closure at line three, you can see actual example.
It makes sure that `2 + 2` is equal to `4`.

Session runs all examples and checks that all of them are correct.
Here's how it looks in terminal:

![Simple Example Output](https://s1.postimg.org/3yxge26htb/Screen_Shot_2017-10-24_at_9.23.22_PM.png)

If any example fails, session will print detailed report of what went wrong in which example,
so you can easily locate source of the problem.

To detect failures programmatically, you can use session's `hasErrors` property, which is
`false` by default, but becomes `true` once there's at least one example failing in your specs.

You can use this property to report failure back to `XCTest`:

```swift
XCTAssert(session.hasErrors == false)
```

This is not strictly necessary. But in cases when your CI relies on XCTest's failure,
it's a handy way to detect errors.

## Describe and context

TODO:

## Matchers

TODO:

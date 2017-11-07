# SSpec

SSpec is a behavior driven development (BDD) framework for Swift and it offers awesome alternative
to standard XCTest.

If you worked with behavior driven development (BDD) before, SSpec should be
already familiar to you. And it's simple to understand and get started for those
who never worked with any BDD frameworks before.

[![Build Status](https://travis-ci.org/dimakura/SSpec.svg?branch=master)](https://travis-ci.org/dimakura/SSpec)

## Installation

Add SSpec as package dependency in your project's `Package.swift` file:

```swift
.package(url: "https://github.com/dimakura/SSpec", from: "0.2.3")
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

Do not forget to import SSPec to use it:

```swift
import SSpec
```

## Getting started

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
actually tries to test. It makes sure that `2 + 2` is indeed `4`.

You can place as many examples inside body of `SSpec.run {...}` as needed.
You should usually create single `SSpec.run {...}` and define all tests inside.
SSpec runs all of the examples and checks their correctness.

If any of the example fails, SSpec will print detailed report of what went
wrong, so you can easily locate source of the problem.

Example output with default SSpec reporter looks like this:

![Sample Output](https://s1.postimg.org/5rt1xb6zhb/Screen_Shot_2017-11-07_at_12.10.44_PM.png)

To detect failures programmatically, you can use `SSpec.hasErrors` property,
which is `false` by default, but becomes `true` once there's at least one
example failing in your specs.

You can use this property to report failure back to `XCTest`:

```swift
XCTAssert(SSpec.hasErrors == false)
```

This is not strictly necessary. But when your CI relies on XCTest's failure, it's a handy way to
detect errors.

## Grouping tests

Two global functions `describe` and `context` are helpful for grouping similar
tests. They are also help to document your code.

```swift
SSpec.run {
  describe("Person") {
    context("with high salary") {
      let person = Person(salary: .High)

      it("is rich") {
        expect(person.isRich).to.beTrue
      }
    }

    context("with low salary") {
      let person = Person(salary: .Low)

      it("is not rich") {
        expect(person.isRich).to.beFalse
      }

      it("is poor") {
        expect(person.isPoor).to.beTrue
      }
    }
  }
}
```

You can use `describe` and `context` interchangeably.
As a rule programmers use `describe` for grouping examples at high-level,
splitting them down to more detailed examples with `context`s.

## Hooks

If several tests use shared variables or need the same initialization code,
you can conveniently use before hook. Before hook runs before each test.

If you need to cleanup after running each test you can do this using after hook.

```swift
describe("Event") {
  var event: Event!

  before {
    // This code runs before each example
    event = Event(priority: .High, dueDate: Date.tomorrow())
    event.save()
  }

  it("is urgent") {
    expect(event.urgent).to.beTrue
  }

  it("is 1 day away") {
    expect(event.daysLeft).to.eq(1)
  }

  after {
    // This code runs after each example
    Database.clean()
  }
}
```

Note that if there are before hooks at different levels, they all get executed
starting from top-level. For after hook execution starts with the lowest level.

```swift
describe("Level 1") {
  before {
    // this runs first
  }

  describe("Level 2") {
    before {
      // this runs second
    }

    it("Example") {
      // this runs after two before hooks
    }

    after {
      // this runs first after the "Example"
    }
  }

  after {
    // this runs last
  }
}
```

## Matchers

### General matcher

All values can be tested on presence with `beNil` matcher:

```swift
it("is nil") {
  expect(value).to.beNil
}
```

### Bool matchers

To test boolean values, use `beTrue` and `beFalse` matchers:

```swift
it("is true") {
  expect(true).to.beTrue
}
it("is false") {
  expect(false).to.beFalse
}
````

### Equatable matchers

TODO:

### String matchers

TODO:

### Array matchers

TODO:

## Change matchers

TODO:

## Custom matchers

Swift is strongly typed language.
SSpec uses types for extending matchers.

Suppose you created custom class `Person`:

```swift
class Person {
  let name: String
  let salary: Double

  init(_ name: String, _ salary: Double) {
    self.name = name
    self.salary = salary
  }

  var isRich: Bool {
    return salary > 50000
  }

  var isPoor: Bool {
    return !isRich
  }
}
```

and want to have your spec to like this:

```swift
describe("Person") {
  let jack = Person("Jack", 100000)
  let jane = Person("Jane", 20000)

  describe(jack.name) {
    it("is rich") {
      expect(jack).to.beRich
    }
  }

  describe(jane.name) {
    it("is poor") {
      expect(jane).to.bePoor
    }
  }
}
```

All you need, is to extend `SSExcept<T>` class:

```swift
extension SSExpect where T == Person {
  var beRich: Void {
    // Note that `assert` takes into account negation status.
    // If you need to know negation status use `isNegate` variable.
    assert(
      value!.isRich,                                // `value` is of type `Person?`
      error: "Expected \(value!.name) to be rich",  // There's also standard `valueStr` variable and
                                                    // `toString(value:)` function you can use.
      errorNegate: "Expected \(value!.name) to be poor"
    )
  }

  var bePoor: Void {
    assert(
      value!.isPoor,
      error: "Expected \(value!.name) to be poor",
      errorNegate: "Expected \(value!.name) to be rich"
    )
  }
}
```

## Configuration

### Reporter

By default SSpec reports progress with dots.

There are other options available:

```swift
SSpec.reporter = .Dot        // default reporter
SSpec.reporter = .Spec       // most document-like reporter
SSpec.reporter = .Progress   // progress bar reporter
```

## Contributing

If you are interested in contributing to SSpec please [read about it here](./CONTRIBUTING.md).

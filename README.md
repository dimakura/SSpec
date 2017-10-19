# SSpec

Behavior driven development in Swift.

[![Build Status](https://travis-ci.org/dimakura/SSpec.svg?branch=master)](https://travis-ci.org/dimakura/SSpec)

## Example

The following code:

```swift
describe("Simple Types") {
  context("Integers") {
    let a = 10
    let b = 5

    it("10 / 5 = 2") {
      expect(a / b).to.eq(2)
    }

    it("10 - 5 = 5") {
      expect(a - b).to.eq(5)
    }

    it("10 + 5 = 15") {
      expect(a + b).to.eq(15)
    }

    it("10 * 5 = 50") {
      expect(a / b).to.eq(2)
    }

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

  context("Strings") {
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
```

Produces output:

![Simple Example](https://s1.postimg.org/1thm1auoy7/Screen_Shot_2017-10-19_at_2.28.36_PM.png)

import XCTest
@testable import SSpec

class SSpecTests: XCTestCase {

  func testExample() {
    SSDescribe("Universe") {
      SSContext("Math") {
        let a = 10
        let b = 5

        SSIt ("\(a) / \(b) = \(a / b)") {
          // TODO:
        }

        SSIt ("\(a) + \(b) = \(a + b)") {
          // TODO:
        }

        SSIt ("\(a) - \(b) = \(a - b)") {
          // TODO:
        }

        SSIt ("\(a) * \(b) = \(a * b)") {
          // TODO:
        }

      }
    }
  }


  static var allTests = [
    ("testExample", testExample),
  ]

}

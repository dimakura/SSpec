@testable import SSpec

func sessionSpecs() {
  context("Session") {
    describe("current session") {
      let s = SSpec.currentSession

      it("is in testing mode") {
        expect(s.mode).to.eq(SSS.Mode.Testing)
      }

      it("doesn't have errors") {
        expect(s.hasErrors).to.beFalse
      }
    }

    describe("#isFocused") {
      let session = SSSession()
      let root = Root(title: "Root")
      let describe1 = Describe(title: "Description 1", parent: root)
      let describe2 = Describe(title: "Description 2", parent: root)
      let example1 = Example(title: "Example 1", parent: describe1)
      let example2 = Example(title: "Example 2", parent: describe2)

      context("Focused list is empty") {
        for node in [root, describe1, describe2, example1, example2] {
          context("Node \(node.title)") {
            it("is focused") {
              expect(session.isFocused(node)).to.beTrue
            }
          }
         }
      }

      context("First example is focused") {
        before {
          session.addFocused(example1)
        }

        for node in [root, describe1, example1] {
          context("Node \(node.title)") {
            it("is focused") {
              expect(session.isFocused(node)).to.beTrue
            }
          }
        }

        for node in [describe2, example2] {
          context("Node \(node.title)") {
            it("is not focused") {
              expect(session.isFocused(node)).to.beFalse
            }
          }
        }
      }
    }
  }
}

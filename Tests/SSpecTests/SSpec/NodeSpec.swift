@testable import SSpec

func nodeSpecs() {
  describe("Node") {
    var root: Root!
    var executionCount = 0
    let runnable: SSRunnable = { executionCount += 1 }

    before {
      executionCount = 0
      root = Root(title: "Root")
    }

    describe("Root") {
      it("has id") {
        expect(root.id).to.not.beNil
      }

      it("has title 'Root'") {
        expect(root.title).to.eq("Root")
      }

      it("is root") {
        expect(root.isRoot).to.beTrue
      }

      it("has no parent") {
        expect(root.parent).to.beNil
      }

      it("has no children") {
        expect(root.children).to.beEmpty
        expect(root.preChildren).to.beEmpty
        expect(root.postChildren).to.beEmpty
      }
    }

    describe("Describe") {
      var describe: Describe!

      before {
        describe = Describe(title: "Something", parent: root, runnable: runnable)
      }

      it("has id") {
        expect(describe.id).to.not.beNil
      }

      it("has title 'Something'") {
        expect(describe.title).to.eq("Something")
      }

      it("has full title 'Something'") {
        expect(describe.fullTitle).to.eq("Something")
      }

      it("is not root") {
        expect(describe.isRoot).to.beFalse
      }

      it("has root as parent") {
        expect(describe.parent).to.eq(root)
      }

      context("no children") {
        it("has no children") {
          expect(describe.children).to.beEmpty
          expect(describe.preChildren).to.beEmpty
          expect(describe.postChildren).to.beEmpty
        }

        it("runs description block on initialization") {
          expect { describe.runInitialization() }.to.change(from: 0, to: 1) { executionCount }
        }

        it("doesn't run description block on testing") {
          expect { describe.runTesting() }.to.not.change { executionCount }
        }
      }

      context("with children") {
        before {
          _ = Example(title: "Example 1", parent: describe, runnable: runnable)
          _ = Example(title: "Example 2", parent: describe, runnable: runnable)
        }

        it("has 2 children") {
          expect(describe.children).to.have.size(2)
          expect(describe.preChildren).to.beEmpty
          expect(describe.postChildren).to.beEmpty
        }

        it("runs description block on initialization") {
          expect { describe.runInitialization() }.to.change(from: 0, to: 1) { executionCount }
        }

        it("runs child examples during testing") {
          expect { describe.runTesting() }.to.change(from: 0, to: 2) { executionCount }
        }
      }
    }

    describe("Before/After") {
      var before1: Before!
      var before2: Before!
      var describe: Describe!
      var after1: After!
      var after2: After!

      before {
        before1 = Before(title: "Before1", parent: root, runnable: runnable)
        after1 = After(title: "After1", parent: root, runnable: runnable)
        describe = Describe(title: "Describe1", parent: root, runnable: runnable)
        before2 = Before(title: "Before2", parent: describe, runnable: runnable)
        after2 = After(title: "After2", parent: describe, runnable: runnable)
        before1.runInitialization()
        before2.runInitialization()
        after1.runInitialization()
        after2.runInitialization()
      }

      context("Root") {
        it("has 1 prechild") {
          expect(root.preChildren).to.eq([before1])
        }

        it("has 1 postchild") {
          expect(root.postChildren).to.eq([after1])
        }
      }

      context("Describe") {
        it("has 1 prechild") {
          expect(describe.preChildren).to.eq([before2])
        }

        it("has 1 postchild") {
          expect(describe.postChildren).to.eq([after2])
        }

        it("has 2 prechildren in full hierarchy") {
          expect(describe.allPreChildren()).to.eq([before1, before2])
        }
        it("has 2 postchildren in full hierarchy") {
          expect(describe.allPostChildren()).to.eq([after2, after1])
        }
      }
    }

    describe("#focused") {
      var description: Describe!

      context("not focused") {
        before {
          description = Describe(title: "Description", parent: root, runnable: nil)
        }

        it("is not focused") {
          expect(description.focused).to.beFalse
        }

        context("default child") {
          var child: Example!

          before {
            child = Example(title: "Example", parent: description, runnable: nil)
          }

          it("is not focused by default") {
            expect(child.focused).to.beFalse
          }
        }

        context("focused child") {
          var child: Example!

          before {
            child = Example(title: "Example", parent: description, runnable: nil, focused: true)
          }

          it("is focused") {
            expect(child.focused).to.beTrue
          }
        }
      }

      context("focused") {
        before {
          description = Describe(title: "Description", parent: root, runnable: nil, focused: true)
        }

        it("is focused") {
          expect(description.focused).to.beTrue
        }

        context("children") {
          var example: Example!

          context("default child") {
            before {
              example = Example(title: "Example", parent: description, runnable: nil)
            }

            it("is focused") {
              expect(example.focused).to.beTrue
            }
          }

          context("not focused child") {
            before {
              example = Example(title: "Example", parent: description, runnable: nil, focused: false)
            }

            it("is focused") {
              expect(example.focused).to.beTrue
            }
          }
        }
      }
    }

    describe("#chain") {
      let root = Root(title: "Root")
      let describe = Describe(title: "Description 1", parent: root)
      let example = Example(title: "Example 1", parent: describe)

      context("root node") {
        let chain = root.chain

        it("has length 1") {
          expect(chain).to.have.size(1)
        }

        it("inclides only root node") {
          expect(chain).to.eq([root])
        }
      }

      context("describe node") {
        let chain = describe.chain

        it("has length 2") {
          expect(chain).to.have.size(2)
        }

        it("inclides full branch") {
          expect(chain).to.eq([root, describe])
        }
      }

      context("example node") {
        let chain = example.chain

        it("has length 3") {
          expect(chain).to.have.size(3)
        }

        it("inclides full branch") {
          expect(chain).to.eq([root, describe, example])
        }
      }
    }
  }
}

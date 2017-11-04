import SSpec

func arraySpecs() {
  describe("Array") {
    context("eq matcher") {
      it("compare equal arrays") {
        expect([1, 2, 3]).to.eq([1, 2, 3])
      }

      it("compare different arrays") {
        expect([1, 2, 3, 4]).to.not.eq([1, 2, 3])
      }
    }

    context("same matcher") {
      it("compare similar arrays") {
        expect([1, 2, 3]).to.eq([1, 2, 3])
        expect([1, 2, 3]).to.be.same([3, 2, 1])
      }

      it("compare different arrays") {
        expect([1, 2, 3]).to.not.be.same([3, 2, 1, 1])
        expect([1, 2, 3]).to.not.be.same([] as [Int])
        expect([1, 2, 3]).to.not.be.same([1, 2, 3, 1, 2, 3])
      }
    }

    context("include matcher") {
      it("compare inclusive arrays") {
        expect([1, 2, 3]).to.include([] as [Int])
        expect([1, 2, 3]).to.include([1])
        expect([1, 2, 3]).to.include([1, 2])
        expect([1, 2, 3]).to.include([1, 2, 3])
        expect([1, 2, 3]).to.include([2, 1, 3])
      }

      it("compare non-inclusive arrays") {
        expect([1, 2, 3]).to.not.include([4])
        expect([1, 2, 3]).to.not.include([1, 2, 3, 0])
      }
    }
  }
}

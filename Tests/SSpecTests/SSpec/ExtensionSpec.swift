import SSpec

func extensionSpec() {
  describe("Extension") {
    context("[1, 2, 3]") {
      let subject = [1, 2, 3]

      it("is not long") {
        expect(subject).to.not.beLong
      }

      it("is short") {
        expect(subject).to.beShort
      }
    }

    context("[1, 2, 3, 4, 5]") {
      let subject = [1, 2, 3, 4, 5]

      it("is long") {
        expect(subject).to.beLong
      }

      it("is not short") {
        expect(subject).to.not.beShort
      }
    }
  }
}

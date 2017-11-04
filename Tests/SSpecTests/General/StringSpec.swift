import SSpec

func stringSpecs() {
  context("String") {
    let text = "Swift is awesome!"

    it("contains another string") {
      expect(text).to.include("awesome")
    }

    it("does not contain another string") {
      expect(text).to.not.include("ugly")
    }
  }
}

import SSpec

func booleanSpecs() {
  context("Bool") {
    it("is true") {
      expect(true).to.beTrue
    }

    it("is false") {
      expect(false).to.beFalse
    }
  }
}

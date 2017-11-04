import SSpec

func nilableSpecs() {
  context("Nilable") {
    it("is nil") {
      expect(nil as String?).to.beNil
    }

    it("is not nil") {
      expect("Some string").to.not.beNil
    }
  }
}

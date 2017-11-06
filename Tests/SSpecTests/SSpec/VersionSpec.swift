@testable import SSpec

func versionSpecs() {
  let expectedVersion = "0.2.2"

  describe("Latest version") {
    let v = SSpec.currentVersion

    it("is \(expectedVersion)") {
      expect(v.description).to.eq(expectedVersion)
    }
  }
}

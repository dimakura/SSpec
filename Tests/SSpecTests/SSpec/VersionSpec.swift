@testable import SSpec

func versionSpecs() {
  let expectedVersion = "0.2.1"

  describe("Latest version") {
    let v = SSpec.currentVersion

    it("is \(expectedVersion)") {
      expect(v.description).to.eq(expectedVersion)
    }
  }
}

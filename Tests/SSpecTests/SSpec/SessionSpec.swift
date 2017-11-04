@testable import SSpec

func sessionSpecs() {
  context("Session") {
    let s = SSpec.currentSession

    it("in testing mode") {
      expect(s.mode).to.eq(SSS.Mode.Testing)
    }

    it("doesn't have errors") {
      expect(s.hasErrors).to.beFalse
    }
  }
}

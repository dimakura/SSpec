/// This collector displays welcome message when session starts.
class Welcomer: SSSession.Collector {
  override func specStarted() {
    print("\n-- Runing SSpec v\(SSpec.currentVersion)\n")
  }
}

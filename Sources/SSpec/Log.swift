/// Single level indent.
fileprivate let singleIndent = "  "


/// Log text with indents corresponding to current level.
func log(_ text: String) {
  let indent = String(repeating: singleIndent, count: currentLevel())
  print("\(indent)\(text)")
}


/// Welcome messaging.
func logWelcome() {
  if isLowestLevel() {
    print("\n-- SSpec 0.1.0\n")
  }
}


/// Report on goodbuy.
func logGoodbye() {
  // TODO: display some stats
  if isLowestLevel() {
    print("\n-- Bye!\n")
  }
}

/// Base reporter interface.
class Reporter: SSSession.Collector {
  static func createReporter() -> Reporter {
    switch SSpec.reporter {
    case .Dot:
      return DotReporter()
    case .Spec:
      return SpecReporter()
    case .Progress:
      return ProgressReporter()
    }
  }

  var totalExamples: Int = 0
  var exampleFailures: Int = 0
  var currentExample: Example?
  var exampleTitles = [Int: String]()
  var errorsByExample = [Int: [String]]()
  var examples: Int = 0
  var skipes:   Int = 0
  var failures: Int { return errorsByExample.count }

  func onSpecStarted() {}

  func onExampleSkipped(node: Example) {}

  func onContextStarted(node: Describe) {}

  func onExampleSuccess(node: Example) {}

  func onExampleFailure(node: Example) {}

  func onSpecEnded() {}

  func log(_ text: String, level: Int = 0) {
    let indent = String(repeating: " ", count: 2 * level)
    print("\(indent)\(text)")
  }

  override func exampleRegistered(node: Example) {
    totalExamples += 1
  }

  override func specStarted() {
    onSpecStarted()
  }

  override func contextStarted(node: Describe) {
    onContextStarted(node: node)
  }

  override func exampleSkipped(node: Example) {
    skipes += 1
    onExampleSkipped(node: node)
  }

  override func exampleStarted(node: Example) {
    examples += 1
    currentExample = node
    exampleFailures = 0
  }

  override func exampleError(error: String) {
    guard let example = currentExample else { return }

    exampleFailures += 1

    if var errors = errorsByExample[example.id] {
      errors.append(error)
      errorsByExample[example.id] = errors
    } else {
      errorsByExample[example.id] = [error]
      exampleTitles[example.id] = example.fullTitle
    }
  }

  override func exampleEnded(node: Example) {
    if exampleFailures > 0 {
      onExampleFailure(node: node)
    } else {
      onExampleSuccess(node: node)
    }
    currentExample = nil
  }

  override func specEnded() {
    onSpecEnded()
    logErrors()
    logSummary()
  }

  private var wasSkipped: Bool {
    return skipes > 0
  }

  private var failed: Bool {
    return failures > 0
  }

  private var wasClean : Bool {
    return !wasSkipped && !failed
  }

  private func logErrors() {
    guard failed else { return }

    print("Failures summary:")

    var exampleNumber = 0
    for (id, errors) in errorsByExample {
      exampleNumber += 1
      print()
      log("\(exampleNumber). \(exampleTitles[id]!):".bold, level: 1)
      if errors.count == 1 {
        log(errors.first!.red, level: 2)
      } else {
        var subExampleNumber = 0
        for error in errors {
          subExampleNumber += 1
          log("\(exampleNumber).\(subExampleNumber)) " + error.red, level: 2)
        }
      }
    }
  }

  private func logSummary() {
    var summary: String = "\(examples) example(s)"
    if wasSkipped { summary += ", " + "\(skipes) skipped".yellow.bold }
    if failed { summary += ", " + "\(failures) failure(s)".red.bold }
    if wasClean { summary += " OK".green }
    print("\nSummary: \(summary)")
  }
}

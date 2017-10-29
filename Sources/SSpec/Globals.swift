/// Describe function.
public func describe(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Context function.
public func context(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.describe(title, runnable)
}

/// Example function.
public func it(_ title: String, _ runnable: SSRunnable? = nil) {
  SSpec.currentSession.it(title, runnable)
}

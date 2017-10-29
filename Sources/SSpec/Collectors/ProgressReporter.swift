//
// SSpec
// ProgressReporter.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import Progress

/// Progress-style reporter.
class ProgressReporter: Reporter {
  var completedExampleCount: Int = 0
  var progressBar: ProgressBar?

  override func onSpecStarted() {
    progressBar = ProgressBar(count: totalExamples, configuration: [ProgressPercent(), ProgressBarLine(barLength: 40)])
  }

  override func onExampleSkipped(node: Example) {
    exampleDone()
  }

  override func onExampleSuccess(node: Example) {
    exampleDone()
  }

  override func onExampleFailure(node: Example) {
    exampleDone()
  }

  private func exampleDone() {
    completedExampleCount += 1
    progressBar!.setValue(completedExampleCount)
  }
}

//
// SSpec
// SessionMode.swift
//
// Created by Dimitri Kurashvili on 2017-10-22
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

/// Session running modes.
enum SessionMode {
  /// Initial phase: initialization.
  case Initializing

  /// Phase for running actual examples.
  case Running

  /// Final reporting phase.
  case Finalizing
}

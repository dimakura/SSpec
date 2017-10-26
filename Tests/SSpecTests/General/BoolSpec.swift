//
// SSpec
// BoolSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-26
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import SSpec

func booleanSpecs() {
  context("Bool") {
    it("is true") {
      expect(true).to.beTrue
    }

    it("is false") {
      expect(false).to.beFalse
    }
  }
}

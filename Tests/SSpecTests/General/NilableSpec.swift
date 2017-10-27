//
// SSpec
// NilableSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-26
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import SSpec

func nilableSpecs() {
  context("Nilable") {
    it("is nil") {
      expect(nil as String?).to.beNil
    }

    it("is not nil") {
      expect("Some string").to.not.beNil
    }
  }
}

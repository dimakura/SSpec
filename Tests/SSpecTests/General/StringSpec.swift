//
// SSpec
// StringSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-26
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import SSpec

func stringSpecs() {
  context("String") {
    let text = "Swift is awesome!"

    it("contains another string") {
      expect(text).to.include("awesome")
    }

    it("does not contain another string") {
      expect(text).to.not.include("ugly")
    }
  }
}

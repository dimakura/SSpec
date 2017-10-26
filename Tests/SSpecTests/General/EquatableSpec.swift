//
// SSpec
// EquatableSpec.swift
//
// Created by Dimitri Kurashvili on 2017-10-26
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

import SSpec

func equatableSpecs() {
  context("Equatable") {
    it("1 == 1") {
      expect(1).to.eq(1)
    }

    it("1 != 2") {
      expect(1).to.not.eq(2)
    }
  }
}

//
// SSpec
// IdGenerator.swift
//
// Created by Dimitri Kurashvili on 2017-10-29
//
// Copyright (c) 2017 Dimitri Kurashvili. All rights reserved
//

struct IdGenerator {
  private static var lastId: Int = 0

  static var nextId: Int {
    lastId += 1
    return lastId
  }
}

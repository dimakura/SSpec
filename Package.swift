// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "SSpec",
  products: [
    .library(
      name: "SSpec",
      targets: ["SSpec"]),
  ],
  dependencies: [
    .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
    .package(url: "https://github.com/jkandzi/Progress.swift", from: "0.3.0")
  ],
  targets: [
    .target(
      name: "SSpec",
      dependencies: ["Rainbow", "Progress"]),
    .testTarget(
      name: "SSpecTests",
      dependencies: ["SSpec"]),
  ]
)

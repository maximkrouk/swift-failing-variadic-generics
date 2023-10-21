// swift-tools-version: 5.9

import PackageDescription
import Foundation

let packageURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
let sourcesURL = packageURL.appending(component: "Sources")

let contents = try FileManager.default
  .contentsOfDirectory(atPath: sourcesURL.path(percentEncoded: false))
  .compactMap { (file: String) -> String? in
    guard file.hasSuffix(".swift") else { return nil }
    return String(file.dropLast(".swift".count))
  }

let package = Package(
  name: "swift-failing-variadic-generics",
  products: contents
    .map { .init($0.trimmingPrefix(while: { $0 == "_" })) }
    .map { .library(name: $0, type: .static, targets: [$0]) },
  targets: contents.flatMap { fileName in
    let targetName = String(fileName.trimmingPrefix(while: { $0 == "_" }))

    let baseTarget: Target = .target(
      name: targetName,
      path: "./Sources",
      sources: ["\(fileName).swift"],
      publicHeadersPath: ""
    )

    let testTarget: Target? = fileName.hasPrefix("_")
    ? nil
    : .testTarget(
      name: "\(targetName)Tests",
      dependencies: [
        .target(name: targetName)
      ],
      path: "Tests",
      sources: ["\(targetName)Tests.swift"]
    )

    return [baseTarget, testTarget].compactMap { $0 }
  }
)

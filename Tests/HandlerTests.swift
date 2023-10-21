import XCTest
@testable import Handler

@available(macOS 14.0.0, *)
class HandlerTests: XCTestCase {
  struct Sample: Equatable {
    var int: Int
    var string: String
    var bool: Bool

    init(
      _ int: Int,
      _ string: String,
      _ bool: Bool
    ) {
      self.int = int
      self.string = string
      self.bool = bool
    }
  }

  func testContainer() {
    var buffer: [Sample] = []

    // ✅ We can initialize container
    let container = HandlerContainer<Int, String, Bool>(action: { int, string, bool in
      buffer.append(.init(int, string, bool))
    })

    // 🛑 We cant call the closure even if the continer has explicit types
    container.action?(0, "", false)
    container.action?(1, "string", true)

    XCTAssertEqual(
      buffer,
      [
        .init(0, "", false),
        .init(1, "string", true)
      ]
    )
  }
}

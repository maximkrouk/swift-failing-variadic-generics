import XCTest
import Pack

class UnpackTests: XCTestCase {
  func testMain() {
    typealias PackedSignature = ((Int, String, Bool)) -> String
    typealias UnpackedSignature = (Int, String, Bool) -> String

    let f: PackedSignature = { args in
      return "\(args.0), \(args.1), \(args.2)"
    }

    // 🛑 Any call to `unpack` function breaks compilation
    // No error is shown inline
    let f_unpacked: UnpackedSignature = unpack(f)

    XCTAssertEqual(
      f((1, "x", false)),
      "1, x, false"
    )

    let sample = (0, "str", true)
    XCTAssertEqual(
      f(sample),
      f_unpacked(sample.0, sample.1, sample.2)
    )
  }
}

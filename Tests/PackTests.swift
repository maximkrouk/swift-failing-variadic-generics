import XCTest
import Pack

class PackTests: XCTestCase {
  func testMain() {
    typealias PackedSignature = ((Int, String, Bool)) -> String
    typealias UnpackedSignature = (Int, String, Bool) -> String

    let f: UnpackedSignature = { int, string, bool in
      return "\(int), \(string), \(bool)"
    }
    
    // 🛑 Any call to `pack` function breaks compilation
    // No error is shown inline
    let f_packed: PackedSignature = pack(f)

    XCTAssertEqual(
      f(1, "x", false),
      "1, x, false"
    )

    let sample = (0, "str", true)
    XCTAssertEqual(
      f(sample.0, sample.1, sample.2),
      f_packed(sample)
    )
  }
}

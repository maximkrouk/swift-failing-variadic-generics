// ✅ This code compiles correctly, tests do not

@inlinable
public func unpack<each Arg, Output>(
  _ f: @escaping ((repeat each Arg)) -> Output
) -> (repeat each Arg) -> Output {
  return { (arg: repeat each Arg) in
    f((repeat each arg))
  }
}

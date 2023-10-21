import Foundation

@available(macOS 14.0.0, iOS 17.0.0, *)
public struct HandlerContainer<each Arg> {
  @usableFromInline
  internal var action: ((repeat each Arg) -> Void)?

  /// Passing an optional closure with variadic args as an argument
  ///
  /// ✅ Memberwise init compiles successfully,
  /// but it's internal, lets say we want a public one:
  /// ```
  /// init(action: (@escaping (repeat each Arg) -> Void)? = nil) {
  ///   self.action = action
  /// }
  /// ```
  /// > 🛑 Closure is already escaping in optional type argument
  ///
  /// After applying suggested fixIt:
  public init(action: ((repeat each Arg) -> Void)? = nil) {
    self.action = action
  }
}

@available(macOS 14.0.0, iOS 17.0.0, *)
@propertyWrapper
public class Handler<each Arg> {

  public init() {}

  public init(wrappedValue: HandlerContainer<repeat each Arg>) {
    self.wrappedValue = wrappedValue
  }

  public var wrappedValue: HandlerContainer<repeat each Arg> = .init()

  /// 🛑 Bypassing an optional closure with variadic args
  @inlinable
  public var projectedValue: ((repeat each Arg) -> Void)? {
    get { wrappedValue.action }
    set { wrappedValue.action = newValue }
  }

  /// Calling an optional closure with variadic args
  ///
  /// 🛑 **Optional chaining does not work**
  /// ```
  /// @inlinable
  /// public func callAsFunction(_ input: repeat each Arg) {
  ///   wrappedValue.action?(repeat each input)
  /// }
  /// ```
  /// > Missing argument for parameter #1 in call
  ///
  /// 🛑 **Optional mapping does not work**
  /// ```
  /// @inlinable
  /// public func callAsFunction(_ input: repeat each Arg) {
  ///   wrappedValue.action.map { $0(repeat each input) }
  /// }
  /// ```
  /// > Missing argument for parameter #1 in call
  ///
  /// ✅ But at least if/guard checks can be used as a workaround
  @inlinable
  public func callAsFunction(_ input: repeat each Arg) {
    guard let action = wrappedValue.action else { return }
    action(repeat each input)
  }

}

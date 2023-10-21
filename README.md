# swift-failing-variadic-generics

Package with examples of weirdly failing variadic generics 🌚

### Structure
- Package generates separate targets and products for each file
- Package does not generate test targets for files prefixed with an underscore `_`

#### Notes

- May fail to process the manifest after file changes, adding/removing `./` to/from `path: "./Sources")` should help spm to rebuild the manifest

### Comments
- Use of Xcode right sidebar is recommended for reading doc comments
- Search for `✅` to find whats working
- Search for `🛑` to find failures

### Contents
- **`Handler`** - [`Sources`]("Sources/Handler.swift") | [`Tests`]("Tests/HandlerTests.swift") | [`External non-variadic example`](https://github.com/CaptureContext/swift-declarative-configuration/blob/main/Sources/FunctionalClosures/Handler.swift)

  > Fails to compile, fails on a call site
  
- **`Pack`** - [`Sources`]("Sources/Pack.swift") | [`Tests`]("Tests/PackTests.swift") | [`External non-variadic example`](https://github.com/CaptureContext/swift-prelude/blob/main/Sources/Prelude/Tuples/Pack.swift)
  
  > Compiles successfully until there are no callers (for example when tests are commented)
  
- **`Unpack`** - [`Sources`]("Sources/Unpack.swift") | [`Tests`]("Tests/UnpackTests.swift") | [`External non-variadic example`](https://github.com/CaptureContext/swift-prelude/blob/main/Sources/Prelude/Tuples/Pack.swift)
  
  > Compiles successfully until there are no callers (for example when tests are commented)


# Package

version       = "0.0.1"
author        = "lbartoletti"
description   = "Accurate Floating Point Sums and Products"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0"

# Documentation

task docs, "Build documentation":
  exec "nim doc --index:on --outdir:pages --project src/AccurateSums.nim"

# Tests

task test, "Runs all tests":
  exec "nim c -r tests/test_array_sum.nim"

task array_sum, "Array sums":
  exec "nim c -r tests/test_array_sum.nim"

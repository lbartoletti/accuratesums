func fastTwoSum*[T: SomeFloat](a, b: T): (T, T) =
  ## Deker's algorithm
  ## pre-condition: |a| >= |b|
  ## you must swap a and b if pre-condition is not satisfied
  ## s + r = a + b exactly (s is result[0] and r is result[1])
  ## s is the nearest FP number of a + B
  assert(abs(a) >= abs(b))
  result[0] = a + b
  result[1] = b - (result[0] - a)

func twoSum*[T](a, b: T): (T, T) =
  ## Møller-Knuth's algorithm.
  ## Improve Deker's algorithm, no branch needed
  ## More operations, but still cheap.
  result[0] = a + b
  let z = result[0] - a
  result[1] = (a - (result[0] - z)) + (b - z)

func sumTwoSum*[T: SomeFloat](v: openArray[T]): T =
  ## sum `v` using `twoSum`
  if len(v) == 0:
    return 0.0

  var s = v[0]
  var e: float
  for i in 1..<v.len-1:
    let sum = twoSum(s, v[i])
    s = sum[0]
    e += sum[1]
  return s + e

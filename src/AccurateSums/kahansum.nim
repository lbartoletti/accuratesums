func kahanSum*[T: SomeFloat](x: openArray[T]): T =
  ## kahan summation
  ## https://en.wikipedia.org/wiki/Kahan_summation_algorithm
  var c = 0.0
  for v in x:
    var y = v - c
    var t = result + y
    c = (t - result) - y
    result = t

func neumaierSum*[T: SomeFloat](x: openArray[T]): T =
  ## improved Kahan–Babuška algorithm
  ## https://en.wikipedia.org/wiki/Kahan_summation_algorithm#Further_enhancements
  if len(x) == 0: return
  result = x[0]
  var c = T(0)
  for i in 1 ..< len(x):
    let xi = x[i]
    let t = result + xi
    if abs(result) >= abs(xi):
      c += (result - t) + xi
    else:
      c += (xi - t) + result
    result = t
  result += c

func kleinSum*[T: SomeFloat](x: openArray[T]): T =
  ## Klein variant
  ## https://en.wikipedia.org/wiki/Kahan_summation_algorithm#Further_enhancements
  var cs = 0.0
  var ccs = 0.0
  for v in x:
    var t = result + v
    var c = 0.0
    var cc = 0.0
    if abs(result) >= abs(v):
      c = (result - t) + v
    else:
      c = (v - t) + result
    result = t
    t = cs + c
    if abs(cs) >= abs(c):
      cc = (cs - t) + c
    else:
      cc = (c - t) + cs
    cs = t
    ccs = ccs + cc
  result = result + cs + ccs

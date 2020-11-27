import math

func pairwise[T](x: openArray[T], i0, n: int): T =
  if n < 128:
    result = x[i0]
    for i in i0 + 1 ..< i0 + n:
      result += x[i]
  else:
    let n2 = n div 2
    result = pairwise(x, i0, n2) + pairwise(x, i0 + n2, n - n2)

func pairwiseSum*[T](x: openArray[T]): T =
  ## Pairwise (cascade) summation of ``x[i0:i0+n-1]``, with O(log n) error growth
  ## (vs O(n) for a simple loop) with negligible performance cost if
  ## the base case is large enough.
  ##
  ## See, e.g.:
  ## * http://en.wikipedia.org/wiki/Pairwise_summation
  ##   Higham, Nicholas J. (1993), "The accuracy of floating point
  ##   summation", SIAM Journal on Scientific Computing 14 (4): 783–799.
  ##
  ## In fact, the root-mean-square error growth, assuming random roundoff
  ## errors, is only O(sqrt(log n)), which is nearly indistinguishable from O(1)
  ## in practice. See:
  ## * Manfred Tasche and Hansmartin Zeuner, Handbook of
  ##   Analytic-Computational Methods in Applied Mathematics (2000).
  ##
  let n = len(x)
  if n == 0: T(0) else: pairwise(x, 0, n)

func pairwiseStSum*[T](x: openArray[T]): T =
  ## Pairwise stacked version
  var partials = newSeq[T]
  for i, v in pairs(x):
    partials.push(v)
    var j = i
    while j mod 2 == 0:
      j = floor(j / 2)
      let p = partials.pop()
      let q = partials.pop()
      partials.push(p + q)

  while partials.len() > 0:
    result = result + partials.pop()

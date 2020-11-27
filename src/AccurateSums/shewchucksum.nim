import twosum

func shewchuckAdd[T: SomeFloat](v: openArray[T]): seq[T] =
  for x in v:
    var x = x
    var i = 0
    for y in result:
      let sum = twoSum(x, y)
      let hi = sum[0]
      let lo = sum[1]
      if lo != 0.0:
        result[i] = lo
        i.inc
      x = hi
    setLen(result, i + 1)
    result[i] = x

func shewchuckTotal[T: SomeFloat](partials: openArray[T]): T =
  var n = partials.len
  if n > 0:
    dec(n)
    result = partials[n]
    var lo = 0.0
    while n > 0:
      var x = result
      dec(n)
      var y = partials[n]
      let (hi, lo) = twoSum(x, y)
      if lo != 0.0:
        break
      if n > 0 and
          (
            (lo < 0.0 and partials[n - 1] < 0.0) or
            (lo > 0.0 and partials[n - 1] > 0.0)
          )
        :
        y = lo + lo
        x = hi + y
        if y == x - hi:
          result = x

func shewchuckSum*[T: SomeFloat](x: openArray[T]): T =
  ## Shewchuk's summation
  ## Full precision sum of values in iterable. Returns the value of the
  ## sum, rounded to the nearest representable floating-point number
  ## using the round-half-to-even rule
  ##
  ## See also:
  ## - https://docs.python.org/3/library/math.html#math.fsum
  ## - https://code.activestate.com/recipes/393090/
  ##
  ## Reference:
  ## Shewchuk, JR. (1996) Adaptive Precision Floating-Point Arithmetic and \
  ## Fast Robust GeometricPredicates.
  ## http://www-2.cs.cmu.edu/afs/cs/project/quake/public/papers/robust-arithmetic.ps
  shewchuckTotal(shewchuckAdd(x))

func fsum*[T: SomeFloat](x: openArray[T]): T =
  ## Alias of shewchuckSum function as python fsum
  shewchuckSum(x)

import unittest

import AccurateSums
from math import pow

test "epsilon":
  var epsilon = 1.0
  while 1.0 + epsilon != 1.0:
    epsilon /= 2.0
  let data = @[1.0, epsilon, -epsilon]
  check kahanSum(data) == 1.0
  check kleinSum(data) == 1.0
  check neumaierSum(data) == 1.0
  check shewchuckSum(data) == 1.0
  check pairwiseSum(data) != 1.0 # known to fail
  check (1.0 + epsilon) - epsilon != 1.0

test "tc1":
  var tc1: seq[float]
  for n in 1 .. 1000:
    tc1.add 1.0 / n.float
  check kahanSum(tc1) == 7.485470860550345
  check kleinSum(tc1) == 7.485470860550345
  check neumaierSum(tc1) == 7.485470860550345
  check shewchuckSum(tc1) == 7.485470860550345
  check pairwiseSum(tc1) == 7.485470860550345

test "tc2":
  var tc2: seq[float]
  for n in 1 .. 1000:
    tc2.add pow(-1.0, n.float) / n.float
  check kahanSum(tc2) == -0.6926474305598203
  check kleinSum(tc2) == -0.6926474305598203
  check neumaierSum(tc2) == -0.6926474305598203
  check shewchuckSum(tc2) == -0.6926474305598203
  check pairwiseSum(tc2) == -0.6926474305598204

test "0.1":
  let data = @[0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
  check shewchuckSum(data) == 1.0
  check kahanSum(data) == 1.0
  check kleinSum(data) == 1.0
  check neumaierSum(data) == 1.0

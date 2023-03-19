import 'dart:collection';

import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'package:math_expressions/math_expressions.dart';

void main(List<String> arguments) {
  List<int> nums1 = [-1, 0, 0, 3, 3, 3, 0, 0, 0];
  int m = 6;
  List<int> nums2 = [1, 2, 2, 4, 5, 6, 2, 1];
  int n = 3;
  Solution().merge(nums1, m, nums2, n);
  print(nums1);
}

class Solution {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    nums1.removeRange(m, m + n);
    nums1.addAll(nums2);
    nums1.sort();
  }
}

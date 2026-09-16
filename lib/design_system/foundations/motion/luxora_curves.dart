import 'package:flutter/animation.dart';

abstract final class LuxoraCurves {
  static const Curve enter = Curves.easeOutQuart;
  static const Curve exit = Curves.easeInQuart;
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve gentle = Curves.easeOutCubic;
  static const Curve ceremonial = Cubic(0.22, 1.0, 0.36, 1.0);
}

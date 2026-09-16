import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/design_system/foundations/colors/luxora_colors.dart';

void main() {
  group('LuxoraColors', () {
    test('obsidian est bien un noir profond', () {
      expect(LuxoraColors.obsidian, const Color(0xFF0B0B0D));
    });

    test('champagne est bien un or', () {
      expect(LuxoraColors.champagne, const Color(0xFFC9A24B));
    });

    test('textPrimary est l ivoire', () {
      expect(LuxoraColors.textPrimary, LuxoraColors.ivory);
    });
  });
}

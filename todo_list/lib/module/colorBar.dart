import 'package:flutter/material.dart';

class ColorDot {
  final Color color;
  final bool isSelected;

  ColorDot({required this.color, this.isSelected = false});
}

final List<ColorDot> colorDots = [
  ColorDot(color: Colors.white),
  ColorDot(color: Colors.red),
  ColorDot(color: Colors.orange),
  ColorDot(color: Colors.yellow),
  ColorDot(color: Colors.green),
  ColorDot(color: Colors.blue),
  ColorDot(color: Colors.indigo),
  ColorDot(color: Colors.purple),
  ColorDot(color: Colors.pink),
  ColorDot(color: Colors.brown),
  ColorDot(color: Colors.grey),
];

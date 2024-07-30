// this file is used to create a list of color dots that will be used in the color bar

import 'package:flutter/material.dart';

class ColorDot {
  final Color color;

  ColorDot({required this.color});
}

// you can add more colors to the list here
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

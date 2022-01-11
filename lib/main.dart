import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(colorScheme: scheme),
      home: HomeScreen(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'dart:math' show Random;

class AssigneeColorService {
  static final Map<String, Color> _assigneeColors = {};

  static Color getColor(String assignee) {
    return _assigneeColors.putIfAbsent(assignee, () {
      final colors = [
        Colors.blue[400]!,
        Colors.purple[400]!,
        Colors.green[400]!,
        Colors.orange[400]!,
        Colors.pink[400]!,
        Colors.teal[400]!,
      ];
      return colors[Random().nextInt(colors.length)];
    });
  }
} 
import 'dart:math';

import 'package:flutter/material.dart';

class AssigneeColorService {
  static final AssigneeColorService _instance =
      AssigneeColorService._internal();
  factory AssigneeColorService() => _instance;
  AssigneeColorService._internal();

  final Map<String, Color> _assigneeColors = {};

  final List<Color> _availableColors = [
    Colors.blue[400]!,
    Colors.purple[400]!,
    Colors.green[400]!,
    Colors.orange[400]!,
    Colors.pink[400]!,
    Colors.teal[400]!,
  ];

  Color getColorForAssignee(String assignee) {
    return _assigneeColors.putIfAbsent(
      assignee,
      () => _availableColors[Random().nextInt(_availableColors.length)],
    );
  }

  Color getAssigneeColor(String assignee) {
    // Generate a consistent color based on the assignee string
    final hash = assignee.hashCode;
    return Colors.primaries[hash % Colors.primaries.length];
  }

  static Color getColor(String initials) {
    return Colors.primaries[initials.hashCode % Colors.primaries.length];
  }
}

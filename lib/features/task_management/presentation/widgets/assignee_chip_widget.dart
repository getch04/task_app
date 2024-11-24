import 'package:flutter/material.dart';
import '../services/assignee_color_service.dart';

class AssigneeChipWidget extends StatelessWidget {
  final String initials;
  final Color? backgroundColor;

  const AssigneeChipWidget({
    super.key,
    required this.initials,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? AssigneeColorService.getColor(initials),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 
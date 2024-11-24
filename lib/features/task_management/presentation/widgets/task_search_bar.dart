import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 55,
        child: TextField(
          decoration: InputDecoration(
            hintText: AppStrings.search,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            suffixIcon: Icon(
              Icons.search,
              size: 30,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
        ),
      ),
    );
  }

  InputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey[300]!),
    );
  }
} 
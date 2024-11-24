import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(Icons.notifications_outlined),
          const Text(
            AppStrings.appTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          _buildIconButton(Icons.archive_outlined),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(icon, size: 32),
        ),
      ),
      onPressed: () {},
    );
  }
} 
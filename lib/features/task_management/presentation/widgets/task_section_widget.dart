import 'package:flutter/material.dart';
import 'package:tasks_app/core/constants/strings.dart';
import 'package:tasks_app/features/task_management/domain/entities/task.dart';
import 'package:tasks_app/features/task_management/presentation/widgets/add_task_bottom_sheet.dart';

import 'task_item_widget.dart';

class TaskSectionWidget extends StatefulWidget {
  final String title;
  final List<Task> tasks;

  const TaskSectionWidget({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  State<TaskSectionWidget> createState() => _TaskSectionWidgetState();
}

class _TaskSectionWidgetState extends State<TaskSectionWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSection(),
        if (!isExpanded)
          Divider(
            color: Colors.grey[300],
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: isExpanded ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isExpanded ? Border.all(color: Colors.grey[300]!) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          if (isExpanded) ...[
            ...widget.tasks.map((task) => Column(
                  children: [
                    TaskItemWidget(task: task),
                    if (task != widget.tasks.last)
                      Divider(
                        color: Colors.grey[300],
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                  ],
                )),
            _buildAddTaskButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const AddTaskBottomSheet(),
          );
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              AppStrings.addTask,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return InkWell(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 38,
                    color: isExpanded ? Colors.grey[500] : Colors.black,
                  ),
                  onPressed: () => setState(() => isExpanded = !isExpanded),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: isExpanded ? const Color(0xFF4525A2) : Colors.black,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 34,
                color: isExpanded ? Colors.grey[500] : Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

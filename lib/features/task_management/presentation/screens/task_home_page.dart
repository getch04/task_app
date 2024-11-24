// lib/features/task_management/presentation/screens/task_list_screen.dart
import 'dart:math' show min, Random;

import 'package:flutter/material.dart';

class Task {
  final String title;
  final DateTime dueDate;
  final List<String> assignees;
  final double progress;

  Task({
    required this.title,
    required this.dueDate,
    required this.assignees,
    this.progress = 0,
  });
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [
    Task(
      title: 'Survey review and analysis',
      dueDate: DateTime(2024, 10, 12, 13), // 1:00 PM
      assignees: ['M', 'T', 'GM', 'F'],
      progress: 3,
    ),
    Task(
      title: 'Calendar integration',
      dueDate: DateTime(2024, 10, 12, 17), // 5:00 PM
      assignees: ['M', 'B'],
      progress: 5,
    ),
    Task(
      title: 'Cloud-based backend for task data and messages',
      dueDate: DateTime(2024, 10, 12, 17), // 5:00 PM
      assignees: ['MG'],
      progress: 0,
    ),
  ];

  final Map<String, bool> _expandedSections = {};
  final Map<String, Color> _assigneeColors = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildQuickFilters(),
            Expanded(
              child: _buildTaskList(),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const Text(
            'DH',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: SizedBox(
        height: 70,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            suffixIcon: Icon(
              Icons.search,
              size: 30,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton('Today', Icons.calendar_today),
          const SizedBox(
            width: 10,
          ),
          _buildFilterButton('Scheduled', Icons.schedule),
          const SizedBox(
            width: 10,
          ),
          _buildFilterButton('Assigned to me', Icons.person_outline),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: const Color(0xFFefecf8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[600]),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView(
      children: [
        _buildTeamSection('Development Team', tasks),
        _buildTeamSection('AIG Study Team', []),
      ],
    );
  }

  Widget _buildTeamSection(String title, List<Task> tasks) {
    _expandedSections.putIfAbsent(title, () => true);
    final isExpanded = _expandedSections[title]!;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: isExpanded ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isExpanded ? Border.all(color: Colors.grey[300]!) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedSections[title] = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 38,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {
                              setState(() {
                                _expandedSections[title] = !isExpanded;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4525A2),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: 34,
                          color: Colors.grey[500],
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded) ...[
                ...tasks.map((task) => Column(
                      children: [
                        _buildTaskItem(task),
                        if (task != tasks.last)
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
        ),
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

  Widget _buildTaskItem(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: task.progress == 100,
            onChanged: (bool? value) {},
            checkColor: Colors.grey[200],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      '${task.progress.toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: task.progress != 0 ? Colors.grey : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.progress != 0
                            ? Colors.amber[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Oct 12  ${task.dueDate.hour}:${task.dueDate.minute.toString().padLeft(2, '0')} PM',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 24.0 * min(task.assignees.length, 2) +
                          (task.assignees.length > 2 ? 24 : 0),
                      height: 24.0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ...task.assignees
                              .take(2)
                              .toList()
                              .asMap()
                              .entries
                              .map((entry) => Positioned(
                                    left: entry.key * 16.0,
                                    child: _buildAssigneeChip(
                                      entry.value,
                                      backgroundColor:
                                          _getAssigneeColor(entry.value),
                                    ),
                                  )),
                          if (task.assignees.length > 2)
                            Positioned(
                              left: 2 * 16.0,
                              child: _buildAssigneeChip(
                                '+${task.assignees.length - 2}',
                                backgroundColor: Colors.yellow[800],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.more_horiz),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssigneeChip(String initials, {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue,
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

  Widget _buildAddTaskButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: Colors.indigo),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.indigo),
            SizedBox(width: 8),
            Text(
              'Add Task',
              style: TextStyle(color: Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Communication',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  Color _getAssigneeColor(String assignee) {
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

// lib/features/task_management/presentation/widgets/add_task_dialog.dart

class AddTaskDialog extends StatefulWidget {
  final Function(String title, String? assignee, DateTime? dueDate)?
      onCreateTask;

  const AddTaskDialog({
    super.key,
    this.onCreateTask,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _taskNameController = TextEditingController();
  String? _selectedMember;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void _handleCreateTask() {
    final title = _taskNameController.text;
    if (title.isEmpty) return;

    DateTime? finalDateTime;
    if (_selectedDate != null && _selectedTime != null) {
      finalDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
    }

    widget.onCreateTask?.call(title, _selectedMember, finalDateTime);
    Navigator.of(context).pop();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildTaskNameField(),
              const SizedBox(height: 24),
              _buildMemberSelection(),
              const SizedBox(height: 24),
              _buildDateSelection(),
              const SizedBox(height: 24),
              _buildTimeSelection(),
              const SizedBox(height: 32),
              _buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Task Name',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _taskNameController,
          decoration: InputDecoration(
            hintText: 'Insert Task Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildMemberSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assign Member (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedMember,
            decoration: const InputDecoration(
              hintText: 'Select Member',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            items: const [
              DropdownMenuItem(value: 'M', child: Text('Member 1')),
              DropdownMenuItem(value: 'T', child: Text('Member 2')),
              DropdownMenuItem(value: 'MG', child: Text('Member 3')),
            ],
            onChanged: (value) => setState(() => _selectedMember = value),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due Date (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : 'Insert Due Date',
                  style: TextStyle(
                    color:
                        _selectedDate != null ? Colors.black : Colors.grey[600],
                  ),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due Time (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectTime,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'Insert Due Time',
                  style: TextStyle(
                    color:
                        _selectedTime != null ? Colors.black : Colors.grey[600],
                  ),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleCreateTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4834D4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Create Task',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

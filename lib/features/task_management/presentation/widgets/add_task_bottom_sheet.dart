import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../providers.dart';

class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedMember;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

  void _handleCreateTask() {
    final title = _titleController.text;
    if (title.isEmpty) return;

    if (_selectedDate != null && _selectedTime != null) {}

    // Add task using the controller
    ref.read(taskControllerProvider.notifier).addTask(
          title,
          _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.addTaskTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _titleController,
              label: AppStrings.taskName,
              validator: Validators.validateRequired,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.assignMember,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedMember,
                    decoration: InputDecoration(
                      labelText: AppStrings.selectMember,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'M', child: Text(AppStrings.member1)),
                      DropdownMenuItem(
                          value: 'T', child: Text(AppStrings.member2)),
                      DropdownMenuItem(
                          value: 'MG', child: Text(AppStrings.member3)),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedMember = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.dueDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : AppStrings.insertDueDate,
                              style: TextStyle(
                                color: _selectedDate != null
                                    ? Colors.black
                                    : Colors.grey[600],
                              ),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.dueTime,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _selectTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : AppStrings.insertDueTime,
                            style: TextStyle(
                              color: _selectedTime != null
                                  ? Colors.black
                                  : Colors.grey[600],
                            ),
                          ),
                          const Icon(Icons.access_time),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 34),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                  text: AppStrings.createTask,
                  onPressed: _handleCreateTask,
                  backgroundColor: const Color(0xff4525a2)),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

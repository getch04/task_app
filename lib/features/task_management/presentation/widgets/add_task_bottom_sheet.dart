part of task_management_presentation_widgets;

/// A bottom sheet widget that provides a form for creating new tasks.
///
/// This widget includes:
/// - Task title input
/// - Member assignment dropdown
/// - Due date picker
/// - Due time picker
/// - Create task button
class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _taskForm = TaskForm();

  @override
  void dispose() {
    _taskForm.dispose();
    super.dispose();
  }

  /// Shows a date picker dialog and updates the selected date in the form
  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),  // Prevents selecting past dates
      lastDate: DateTime.now().add(const Duration(days: 365)),  // Limits to 1 year ahead
    );
    if (picked != null) {
      setState(() => _taskForm.selectedDate = picked);
    }
  }

  /// Shows a time picker dialog and updates the selected time in the form
  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _taskForm.selectedTime = picked);
    }
  }

  /// Validates and submits the task creation form
  void _handleCreateTask() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Implement task creation logic
    // Should include:
    // - Creating Task entity from form data
    // - Calling task repository to save
    // - Showing success/error feedback

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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildMemberDropdown(),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 16),
              _buildTimePicker(),
              const SizedBox(height: 34),
              _buildCreateButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.addTaskTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );

  Widget _buildTitleField() => CustomTextField(
        controller: _taskForm.titleController,
        label: AppStrings.taskName,
        validator: Validators.validateRequired,
      );

  Widget _buildMemberDropdown() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.assignMember,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _taskForm.selectedMember,
              decoration: InputDecoration(
                labelText: AppStrings.selectMember,
                filled: true,
                fillColor: AppTheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppTheme.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppTheme.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppTheme.primary),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'M', child: Text(AppStrings.member1)),
                DropdownMenuItem(value: 'T', child: Text(AppStrings.member2)),
                DropdownMenuItem(value: 'MG', child: Text(AppStrings.member3)),
              ],
              onChanged: (value) =>
                  setState(() => _taskForm.selectedMember = value),
            ),
          ),
        ],
      );

  Widget _buildDatePicker() => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.dueDate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _taskForm.selectedDate != null
                            ? '${_taskForm.selectedDate!.day}/${_taskForm.selectedDate!.month}/${_taskForm.selectedDate!.year}'
                            : AppStrings.insertDueDate,
                        style: TextStyle(
                          color: _taskForm.selectedDate != null
                              ? AppTheme.textPrimary
                              : AppTheme.textSecondary,
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
      );

  Widget _buildTimePicker() => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.dueTime,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectTime,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _taskForm.selectedTime != null
                            ? _taskForm.selectedTime!.format(context)
                            : AppStrings.insertDueTime,
                        style: TextStyle(
                          color: _taskForm.selectedTime != null
                              ? AppTheme.textPrimary
                              : AppTheme.textSecondary,
                        ),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildCreateButton() => SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: AppStrings.createTask,
          onPressed: _handleCreateTask,
          backgroundColor: AppTheme.primary,
        ),
      );
}

/// Manages the form state and data for task creation
class TaskForm {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedMember;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  /// Returns the current title input value
  String get title => titleController.text;

  /// Returns the current description input value
  String get description => descriptionController.text;

  /// Cleans up controllers to prevent memory leaks
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }

  /// Combines the selected date and time into a single DateTime object
  ///
  /// Returns null if either date or time is not selected
  DateTime? getDueDateTime() {
    if (selectedDate == null || selectedTime == null) return null;

    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
  }
}

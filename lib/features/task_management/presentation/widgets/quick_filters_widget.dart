part of task_management_presentation_widgets;


class QuickFiltersWidget extends StatelessWidget {
  const QuickFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(AppStrings.today, Icons.calendar_today, context),
          const SizedBox(width: 10),
          _buildFilterButton(AppStrings.scheduled, Icons.schedule, context),
          const SizedBox(width: 10),
          _buildFilterButton(AppStrings.assignedToMe, Icons.person_outline, context),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, IconData icon, BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: AppTheme.iconBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.textSecondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
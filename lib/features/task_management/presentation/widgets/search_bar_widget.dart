part of task_management_presentation_widgets;


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 55,
        child: TextField(
          decoration: InputDecoration(
            hintText: AppStrings.search,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            suffixIcon: Icon(Icons.search, size: 30, color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey[300]!),
    );
  }
}
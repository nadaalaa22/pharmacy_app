import 'package:flutter/material.dart';
import '../../data/models/medicine_data.dart';

class MedicineSearchDelegate extends SearchDelegate<MedicineModel?> {
  final List<MedicineModel> medicines;

  MedicineSearchDelegate({required this.medicines});

  @override
  String get searchFieldLabel => 'Search Medicines';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Pass null only if the user cancels the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement how the search results are displayed
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<MedicineModel> suggestions = query.isEmpty
        ? []
        : medicines
        .where((medicine) => medicine.productName
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final MedicineModel medicine = suggestions[index];
        return ListTile(
          title: Text(medicine.productName),
          // Add other details if needed
          onTap: () {
            close(context, medicine);
          },
        );
      },
    );
  }
}
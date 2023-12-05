import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of orders
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('Order #${index + 1}'),
              subtitle: Text(
                  'Date: ${DateTime.now().toString()}'), // Replace with actual date
              trailing: Text('Total: 100 EGP'), // Replace with actual total
              onTap: () {
                // Handle tapping on a specific order
                // You can navigate to a detailed order view or show more information.
              },
            ),
          );
        },
      ),
    );
  }
}
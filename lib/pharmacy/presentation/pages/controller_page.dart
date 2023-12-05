import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

import 'package:flutter/material.dart';
import 'package:pharmacy_app/pharmacy/presentation/pages/kits_page.dart';
import 'package:pharmacy_app/pharmacy/presentation/pages/products_page.dart';
class ControllerPage extends StatefulWidget {
  ControllerPage({Key? key}) : super(key: key);

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.personal_injury_outlined,
      "Products",
      Colors.black54,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      Icons.medical_services,
      "Kits",
      Colors.black54,
      labelStyle: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: bodyContainer(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNav(),
          )
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Color? selectedColor = tabItems[selectedPos].circleColor;

    // Use a switch statement to determine which page to display
    switch (selectedPos) {
      case 0:
        return ProductsPage(); // Assuming ProductsPage is a StatelessWidget
      case 1:
        return KitsPage(); // Assuming KitsPage is a StatelessWidget
      default:
        return Container(); // Return a default widget if none match
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Color(0xffe4d4c5),
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/presentation/bloc/medicine/medicine_bloc.dart';
import 'package:pharmacy_app/pharmacy/presentation/pages/order_details_page.dart';
import 'package:pharmacy_app/pharmacy/presentation/pages/your_cart_page.dart';
import 'package:pharmacy_app/user/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:pharmacy_app/user/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import 'package:pharmacy_app/user/presentation/pages/login_page.dart';

import '../../data/models/cart_data.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/product_grid_tile.dart';
import 'history_page.dart';
import 'medicine_search_delegate.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Set name;
  late String userId = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    context.read<MedicineBloc>().add(GetMedicines());
  }

  Future<void> _initializeData() async {
    context.read<UserDataBloc>().add(GetUserEvent());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    setState(() {});
    print(userId);
  }
  int total(List<CartModel> cartModels) {
    int total = 0;
    for (int i = 0; i < cartModels.length; i++) {
      if(cartModels[i].userId == userId) {
        total += cartModels[i].qty;
      }
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    int cartItemCount = 5;

    return BlocBuilder<MedicineBloc, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineLoaded) {
            return Scaffold(
              backgroundColor: Color(0xfff2e9e2),
              appBar: AppBar(
                backgroundColor: Color(0xffe4d4c5),
                leading: Builder(
                  builder: (context) =>
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 30,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                ),
                title: Text(
                  'M\'s Remedies',
                  style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _showSearchBottomSheet(context);
                    },
                  ),

                  SizedBox(width: 15),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => YourCartPage()));
                        },
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is CartLoadedState) {
                              return Text(
                                '${total(state.cartModels)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              drawer: BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    print(state);
                    if (state is UserLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    print(state);
                    if (state is UserLoadedState) {
                      var listOfNames = state.usersModel.where((element) =>
                      element.id == userId).toList();
                      print(listOfNames);
                      String name = listOfNames[0].name;
                      return Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            DrawerHeader(
                              decoration: BoxDecoration(
                                color: Color(0xffe4d4c5),
                              ),
                              child: Center(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OrderDetailsPage()),
                                    );
                                  },
                                  child: Text(
                                    'Ongoing',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'MyFont',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HistoryPage()),
                                    );// Close the drawer if needed

                                  },
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'MyFont',
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<AuthenticationBloc>().add(
                                        SignOutEvent());
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) =>
                                            LoginPage()), (
                                            route) => false);

                                  },
                                  child: const Text(
                                    'Log out',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'MyFont',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Add more ListTile widgets for additional menu items
                          ],
                        ),
                      );
                    }
                    return SizedBox();
                  }
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                ),

                itemBuilder: (BuildContext context, int index) =>
                    ProductGridTile(medicineData: state.medicines[index],),
                itemCount: state.medicines.length,
              ),
            );
          }
          return const SizedBox();
        }

    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xffEBE7DC),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                ),
                controller: _searchController,
                onChanged: (value) {
                  _filterProducts(value);
                },
              ),
              const SizedBox(height: 16),
              CustomKeyboard(
                controller: _searchController,
                onKeyPressed: (char) {
                  if (char == 'ALL') {
                    _searchController.clear();
                    _filterProducts('');
                  } else {
                    setState(() {
                      _searchController.text += char;
                      _searchController.selection =
                          TextSelection.fromPosition(TextPosition(
                            offset: _searchController.text.length,
                          ));
                      _filterProducts(_searchController.text);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      // Show all products when query is empty
      context.read<MedicineBloc>().add(GetMedicines());
    } else {
      context.read<MedicineBloc>().add(SearchProducts(query: query));
    }
  }

}

class CustomKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onKeyPressed;

  const CustomKeyboard({required this.controller, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 27, // 26 alphabets + 1 for "ALL"
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                onKeyPressed('ALL');
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('ALL'),
              ),
            );
          } else {
            final char = String.fromCharCode('A'.codeUnitAt(0) + index - 1);
            return InkWell(
              onTap: () {
                onKeyPressed(char);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(char),
              ),
            );
          }
        },
      ),
    );
  }
}

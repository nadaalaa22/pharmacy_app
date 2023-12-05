import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/data/models/user_order_data.dart';
import 'package:pharmacy_app/pharmacy/presentation/bloc/user_order/user_order_bloc.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late String userId = '';
  late UserOrderData userOrderData;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    context.read<UserOrderBloc>().add(GetOrdersData());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    setState(() {});
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2e9e2),
      appBar: AppBar(
        backgroundColor: const Color(0xffe4d4c5),
        title: const Text(
          'Order Details',
          style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
        ),
      ),
      body: BlocBuilder<UserOrderBloc, UserOrderState>(
        builder: (context, state) {
          if (state is UserOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserOrderLoaded) {
            for (int i = 0; i < state.userOrdersData.length; i++) {
              if (state.userOrdersData[i].userID == userId) {
                userOrderData = state.userOrdersData[i];
              }
            }
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Details:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Name : ${userOrderData.userName}',
                      style: TextStyle(fontSize: 18)),
                  Text('Email: ${userOrderData.email}',
                      style: TextStyle(fontSize: 18)),
                  Text('Phone: ${userOrderData.phoneNumber}',
                      style: TextStyle(fontSize: 18)),
                  Text('Notes: ${userOrderData.notes}',
                      style: TextStyle(fontSize: 18)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.black, // Specify the color of the line
                      thickness: 1.0, // Specify the thickness of the line
                      height: 20.0, // Specify the height of the line
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Text(
                          'QTY',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'MyFont',
                          ),
                        ),
                        Spacer(),
                        Text(
                          'PRODUCT NAME',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'MyFont',
                          ),
                        ),
                        Spacer(),
                        Text(
                          'PRICE',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'MyFont',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemBuilder: (_, i) => CheckoutList(),
                  //     itemCount: 5,
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.black, // Specify the color of the line
                      thickness: 1.0, // Specify the thickness of the line
                      height: 20.0, // Specify the height of the line
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'MyFont',
                          ),
                        ),
                        Spacer(),
                        Text(
                          '450 EGP',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'MyFont',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffe4d4c5),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the return order action
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Return Order'),
                              content: Text(
                                  'Are you sure you want to return this order?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Perform the return order action
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Customize the button color
                        onPrimary: Colors.white, // Customize the text color
                      ),
                      child: Text(
                        'Return Order',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is UserOrderError) {
            return const Center(
                child: Text(
              'There are no orders currently.',
              style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
            ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

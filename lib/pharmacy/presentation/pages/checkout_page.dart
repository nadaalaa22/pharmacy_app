import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/data/models/user_order_data.dart';
import 'package:pharmacy_app/pharmacy/presentation/widgets/checkout_list.dart';

import '../../../user/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import '../../data/models/cart_data.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/user_order/user_order_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int sum = 0;

  void updateTotalSum(List<CartModel> cartModels) {
    sum = 0;
    for (int i = 0; i < cartModels.length; i++) {
      if(cartModels[i].userId == userId) {
        sum += cartModels[i].medicineModel.price * cartModels[i].qty;
      }
    }
  }
  late String userId = '';
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    setState(() {});
    print(userId);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2e9e2),
      appBar: AppBar(
        backgroundColor: const Color(0xffe4d4c5),
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoadedState) {
            updateTotalSum(state.cartModels);
            return Column(
              children: [
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
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, i) => CheckoutList(
                      cartModel: state.cartModels.where((element) => element.userId == userId).toList()[i],
                    ),
                    itemCount: state.cartModels.where((element) => element.userId == userId).toList().length,
                  )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.black, // Specify the color of the line
                    thickness: 1.0, // Specify the thickness of the line
                    height: 20.0, // Specify the height of the line
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'MyFont',
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${sum}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'MyFont',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffe4d4c5),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        _showOrderConfirmationDialog(context);
                      },
                      child: const Text(
                        'CONFIRM ORDER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'MyFont',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delivery details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  UserOrderData userOrderData = UserOrderData(
                      userID: '',
                      userName: nameController.text,
                      email: emailController.text,
                      phoneNumber: phoneController.text,
                      notes: notesController.text);
                  context.read<UserOrderBloc>().add(SetOrderData(userOrderData: userOrderData));
                  Navigator.pop(context); // Close the overlay page
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Color(0xfff5e0c0)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

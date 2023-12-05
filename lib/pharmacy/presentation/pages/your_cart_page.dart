import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/presentation/pages/checkout_page.dart';
import 'package:pharmacy_app/pharmacy/presentation/widgets/cart.dart';

import '../../data/models/cart_data.dart';
import '../bloc/cart/cart_bloc.dart';

class YourCartPage extends StatefulWidget {
  const YourCartPage({Key? key}) : super(key: key);

  @override
  State<YourCartPage> createState() => _YourCartPageState();
}

class _YourCartPageState extends State<YourCartPage> {
  int sum = 0;
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
          'Your Cart',
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
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (_, i) => CartWidget(
                    cartModel: state.cartModels.where((element) => element.userId == userId).toList()[i],
                  ),
                  itemCount: state.cartModels.where((element) => element.userId == userId).toList().length,
                )),
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
                        style: TextStyle(
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
                        color: Color(0xffe4d4c5)),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutPage()));
                      },
                      child: const Text(
                        'PROCEED TO CHECKOUT',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'MyFont'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
  void updateTotalSum(List<CartModel> cartModels) {
    sum = 0;
    for (int i = 0; i < cartModels.length; i++) {
      if(cartModels[i].userId == userId) {
        sum += cartModels[i].medicineModel.price * cartModels[i].qty;
      }
    }


  }
}





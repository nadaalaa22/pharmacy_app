import 'package:flutter/material.dart';
import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';

class CheckoutList extends StatelessWidget {
  final CartModel cartModel ;
   CheckoutList({Key? key, required this.cartModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0,left: 30, right: 20),
      child: Row(
        children: [
          Text(
            "${cartModel.qty}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),
          ),SizedBox(width: 100,),
          Text(
            '${cartModel.medicineModel.productName}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),
          ),
          Spacer(),
          Text(
            "${cartModel.medicineModel.price*cartModel.qty} EGP",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,

            ),
          ),

        ],
      ),
    );
  }
}

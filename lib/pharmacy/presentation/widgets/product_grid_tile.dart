import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';
import '../../data/models/medicine_data.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/medicine/medicine_bloc.dart';

class ProductGridTile extends StatefulWidget {
  const ProductGridTile({
    super.key, required this.medicineData,
  });

  final MedicineModel medicineData;

  @override
  State<ProductGridTile> createState() => _ProductGridTileState();

}

class _ProductGridTileState extends State<ProductGridTile> {
  int qty = 0 ;
  CartModel? cartModel ;
  late String userId = '';
  @override
  void initState() {
    context.read<CartBloc>().add(GetCart());
    //context.read<MedicineBloc>().add(GetMedicines());
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
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState)
          {
            return const Center(child: CircularProgressIndicator());
          }
        if (state is CartLoadedState) {
          for (int i = 0; i < state.cartModels.length; i++) {
            if (state.cartModels[i].medicineModel.productId ==
                widget.medicineData.productId && state.cartModels[i].userId == userId) {
              print('from iffff');
              qty = state.cartModels[i].qty;
              cartModel = state.cartModels[i];
              print(cartModel);
            }
          }
          return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage()));
            },
            child: SizedBox(
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  footer: Container(
                      height: 70,
                      color: Color(0xffe4d4c5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.medicineData.productName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'MyFont',
                                  fontWeight: FontWeight.w700),
                            ),


                            Row(
                              children: [
                                Text(
                                 '${widget.medicineData.price.toString()} EGP',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  qty==0?'':qty.toString(),
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    qty -- ;
                                    for (int i = 0; i < state.cartModels.length; i++) {
                                      if (state.cartModels[i].medicineModel.productId ==
                                          widget.medicineData.productId) {
                                         state.cartModels[i].qty = qty;
                                         cartModel = state.cartModels[i];
                                      }
                                    }
                                    if(qty == 0)
                                      {
                                        context.read<CartBloc>().add(DeleteCart(cartModel:cartModel??
                                            CartModel(
                                                qty: qty,
                                                medicineModel:
                                                widget.medicineData,
                                                id: '', userId: '',)));
                                      }else {
                                      context.read<CartBloc>().add(UpdateCart(
                                          cartModel: cartModel ??
                                              CartModel(

                                                  qty: qty,
                                                  medicineModel:
                                                  widget.medicineData,
                                                  id: '',  userId: '')));
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_shopping_cart,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: () {
                                    qty ++ ;
                                    print(qty);
                                    for (int i = 0; i < state.cartModels.length; i++) {
                                      if (state.cartModels[i].medicineModel.productId ==
                                          widget.medicineData.productId) {
                                        state.cartModels[i].qty = qty ;
                                        cartModel = state.cartModels[i];
                                      }
                                    }
                                    if (qty==1)
                                      {
                                        print('nada');
                                        context.read<CartBloc>().add(SetCart(cartModel: cartModel??
                                            CartModel(

                                                qty: qty,
                                                medicineModel:
                                                widget.medicineData,
                                                id: '', userId: '')));
                                      }


                                    else {
                                      context.read<CartBloc>().add(UpdateCart(cartModel: cartModel??
                                          CartModel(
                                              qty: qty,
                                              medicineModel:
                                              widget.medicineData,
                                              id: '', userId: '')));
                                    }
                                    setState(() {
                                    });

                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart_outlined,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      )),
                  child: Image.asset(
                    widget.medicineData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
        }
        return SizedBox();
      },
    );
  }
}

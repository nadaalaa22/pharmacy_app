import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';

import '../bloc/cart/cart_bloc.dart';

class CartWidget extends StatefulWidget {
  final CartModel cartModel;

  const CartWidget({Key? key, required this.cartModel}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int medCount = 0;
  int qty = 0;

  CartModel? cartModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: 380,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.cartModel.medicineModel.imageUrl,
                fit: BoxFit.cover,
                width: 180,
                height: 150,
              ),
              Container(
                width: 200,
                height: 150,
                color: Color(0xffe4d4c5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartModel.medicineModel.productName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'MyFont',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${widget.cartModel.medicineModel.price*widget.cartModel.qty} EGP",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          if (state is CartLoadedState) {
                            for (int i = 0; i < state.cartModels.length; i++) {
                              if (state.cartModels[i].medicineModel.productId ==
                                  widget.cartModel.medicineModel.productId) {
                                qty = state.cartModels[i].qty;
                                cartModel = state.cartModels[i];
                              }
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    qty--;
                                    for (int i = 0;
                                    i < state.cartModels.length;
                                    i++) {
                                      if (state.cartModels[i].medicineModel
                                          .productId ==
                                          widget.cartModel.medicineModel
                                              .productId) {
                                        state.cartModels[i].qty = qty;
                                        cartModel = state.cartModels[i];
                                      }
                                    }
                                    if (qty == 0) {
                                      context.read<CartBloc>().add(DeleteCart(
                                        cartModel: cartModel ??
                                            CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              id: '',
                                              userId: '',
                                            ),
                                      ));
                                    } else {
                                      context.read<CartBloc>().add(UpdateCart(
                                        cartModel: cartModel ??
                                            CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              id: '',
                                              userId: '',
                                            ),
                                      ));
                                    }
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.white,
                                  heroTag: 'remove_${widget.cartModel.id}',
                                  // Unique hero tag for the remove button
                                  mini: true,
                                  child: Icon(Icons.remove),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    widget.cartModel.qty.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                FloatingActionButton(
                                  onPressed: () {
                                    qty++;
                                    for (int i = 0;
                                    i < state.cartModels.length;
                                    i++) {
                                      if (state.cartModels[i].medicineModel
                                          .productId ==
                                          widget.cartModel.medicineModel
                                              .productId) {
                                        state.cartModels[i].qty = qty;
                                        cartModel = state.cartModels[i];
                                      }
                                    }
                                    if (qty == 1) {
                                      context.read<CartBloc>().add(SetCart(
                                        cartModel: cartModel ??
                                            CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              id: '',
                                              userId: '',
                                            ),
                                      ));
                                    } else {
                                      context.read<CartBloc>().add(UpdateCart(
                                        cartModel: cartModel ??
                                            CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              id: '',
                                              userId: '',
                                            ),
                                      ));
                                    }
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.white,
                                  heroTag: 'add_${widget.cartModel.id}',
                                  // Unique hero tag for the add button
                                  mini: true,
                                  child: Icon(Icons.add),
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

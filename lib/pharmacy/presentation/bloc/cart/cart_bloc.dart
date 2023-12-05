import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';

import '../../../data/datasource/cart_remote_ds.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRemoteDs cartRemoteDs;
  CartBloc({required this.cartRemoteDs}) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is GetCart) {
          emit(CartLoadingState());
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoadedState(cartModels: carts));
        }
        else if (event is SetCart) {
          emit(CartLoadingState());
          await cartRemoteDs.setCart(event.cartModel);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoadedState(cartModels: carts));
        }
        else if (event is UpdateCart) {
          emit(CartLoadingState());
          await cartRemoteDs.updateCart(event.cartModel);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoadedState(cartModels: carts));
        }
        else if (event is DeleteCart) {
          emit(CartLoadingState());
          await cartRemoteDs.deleteCart(event.cartModel.id);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoadedState(cartModels: carts));
        }
      } catch (e) {
        print('Error in MedicineBloc: $e');
        emit(CartError());
      }
    });
  }
}

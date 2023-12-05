part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class CartLoadingState extends CartState {}
class CartLoadedState extends CartState {
  final List<CartModel> cartModels ;

  CartLoadedState({required this.cartModels});

}
class CartError extends CartState {}
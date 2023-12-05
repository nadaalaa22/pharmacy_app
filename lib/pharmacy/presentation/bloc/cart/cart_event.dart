part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}
class SetCart extends CartEvent {
  final CartModel cartModel ;

  SetCart({required this.cartModel});
}
class DeleteCart extends CartEvent {
  final CartModel cartModel ;

  DeleteCart({required this.cartModel});
}
class UpdateCart extends CartEvent {
  final CartModel cartModel ;

  UpdateCart({required this.cartModel});
}
class GetCart extends CartEvent {}

part of 'user_order_bloc.dart';

@immutable
abstract class UserOrderEvent {}

class SetOrderData extends UserOrderEvent {
  final UserOrderData userOrderData;

  SetOrderData({required this.userOrderData});
}

class GetOrdersData extends UserOrderEvent {}

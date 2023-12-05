part of 'user_order_bloc.dart';

@immutable
abstract class UserOrderState {}

class UserOrderInitial extends UserOrderState {}
class UserOrderLoading extends UserOrderState {}
class UserOrderLoaded extends UserOrderState {
 final  List<UserOrderData> userOrdersData ;

  UserOrderLoaded({required this.userOrdersData});
}
class UserOrderError extends UserOrderState {}

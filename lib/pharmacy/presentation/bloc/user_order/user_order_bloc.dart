import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/datasource/user_order_remote_ds.dart';
import '../../../data/models/user_order_data.dart';

part 'user_order_event.dart';

part 'user_order_state.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final UserOrderRemoteDs userOrderRemoteDs;

  UserOrderBloc(this.userOrderRemoteDs) : super(UserOrderInitial()) {
    on<UserOrderEvent>((event, emit) async {
      try {
        if (event is GetOrdersData) {
          emit(UserOrderLoading());
          List<UserOrderData> userOrdersData =
              await userOrderRemoteDs.getDataOrderedForUser();
          print(userOrdersData);
          if (userOrdersData.isNotEmpty) {
            emit(UserOrderLoaded(userOrdersData: userOrdersData));
          }
          else{
            emit(UserOrderError());
          }
        } else if (event is SetOrderData) {
          emit(UserOrderLoading());
          await userOrderRemoteDs.setUserDataOrdered(event.userOrderData);
          List<UserOrderData> userOrdersData =
              await userOrderRemoteDs.getDataOrderedForUser();
          emit(UserOrderLoaded(userOrdersData: userOrdersData));
        }
      } catch (e) {
        print('Error in UserOrderBloc: $e');
        emit(UserOrderError());
      }
    });
  }
}

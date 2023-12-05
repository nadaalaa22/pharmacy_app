import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';

import '../../../core/db_helper.dart';
import '../models/user_order_data.dart';

abstract class UserOrderRemoteDs {
  Future setUserDataOrdered(UserOrderData userOrderData);

  ///
  Future<List<UserOrderData>> getDataOrderedForUser();

  ///
}

class UserOrderRemoteDsImpl extends UserOrderRemoteDs {
  final RemoteDBHelper dbHelper;

  UserOrderRemoteDsImpl({required this.dbHelper});

  String collectionName = 'user data ordered';


  @override
  Future<List<UserOrderData>> getDataOrderedForUser() async =>
      List<UserOrderData>.from(
          await dbHelper.get(collectionName, UserOrderData.fromDoc));

  @override
  Future setUserDataOrdered(UserOrderData userOrderData) async {
    await dbHelper.add(collectionName, userOrderData.toMap());
  }
}

import 'package:pharmacy_app/pharmacy/data/models/cart_data.dart';

import '../../../core/db_helper.dart';
import '../models/medicine_data.dart';


abstract class CartRemoteDs {
  Future setCart(CartModel cartModel);
  ///
  Future<List<CartModel>> getCartsForUser();
  ///

  Future<void> updateCart (CartModel cartModel) ;
  ///

  Future<void> deleteCart (String productID) ;

}

class CartRemoteDsImpl extends CartRemoteDs {
  final RemoteDBHelper dbHelper;
  CartRemoteDsImpl({required this.dbHelper});
  String collectionName = 'cart';


  @override
  Future<void> deleteCart(String productID)=>
      dbHelper.delete(collectionName, productID);

  @override
  Future<List<CartModel>> getCartsForUser() async => List<CartModel>.from(
      await dbHelper.get(collectionName, CartModel.fromDoc));

  @override
  Future setCart(CartModel cartModel) async {

    await dbHelper.add(collectionName, cartModel.toMap());

  }

  @override
  Future<void> updateCart(CartModel cartModel)  =>
      dbHelper.update(collectionName, cartModel.id, cartModel.toMap());
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'medicine_data.dart';

class CartData {
  String userId, id;
  int qty;
  MedicineModel medicineModel;
  CartData(
      {required this.userId,
        required this.qty,
        required this.medicineModel,
        required this.id});
}

class CartModel extends CartData {
  CartModel({
    required super.userId,
    required super.qty,
    required super.medicineModel,
    required super.id,
  }) ;

  Map<String, dynamic> toMap() => {

    'qty': qty,
    'medicineModel': medicineModel.toMap(),
    'userId':FirebaseAuth.instance.currentUser!.uid ,
  };

  factory CartModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CartModel(
      userId: doc.data()['userId'],
      qty: doc.data()['qty'],
      medicineModel: MedicineModel(
        productName: doc.data()['medicineModel']['productName'],
        price: doc.data()['medicineModel']['price'],
        imageUrl: doc.data()['medicineModel']['imageUrl'],
        description: doc.data()['medicineModel']['description'],
        productId: doc.data()['medicineModel']['productId'],
      ),
      id: doc.id,
    );
  }
}

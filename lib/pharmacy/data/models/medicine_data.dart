import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineData {
  String productName, imageUrl, description;
  int productId, price;

  MedicineData(
      {required this.description,
        required this.productName,
        required this.price,
        required this.imageUrl,
        required this.productId});
}
class MedicineModel extends MedicineData {
  MedicineModel({
    required super.description,
    required super.productName,
    required super.price,
    required super.imageUrl,
    required super.productId,
  }) ;

  Map<String, dynamic> toMap() => {
    'productName': productName,
    'price': price,
    'imageUrl': imageUrl,
    'description': description,
    'productId': productId,
  };

  factory MedicineModel.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
      MedicineModel(
        productName: doc.data()['productName'],
        price: doc.data()['price'],
        imageUrl: doc.data()['imageUrl'],
        description: doc.data()['description'],
        productId: doc.data()['productId'],
      );
}


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/db_helper.dart';
import '../models/medicine_data.dart';
import 'medicine_local_ds.dart';

abstract class MedicineRemoteDs {
  Future setMedicines();
  ///
  Future<List<MedicineModel>> getMedicines();
  ///
  Future<List<MedicineModel>> searchProducts(String query) ;
}

class MedicineRemoteDsImpl extends MedicineRemoteDs {
  final RemoteDBHelper dbHelper;
  MedicineRemoteDsImpl({required this.dbHelper});
  String medicineCollection = 'medicine';
  @override
  Future<List<MedicineModel>> getMedicines() async => List<MedicineModel>.from(
      await dbHelper.get(medicineCollection, MedicineModel.fromDoc));

  @override
  Future setMedicines() async {
    for (int i = 0; i < medicines.length; i++) {
      MedicineModel medicineModel = medicines[i];
      await dbHelper.add(medicineCollection, medicineModel.toMap());
    }
  }

  Future<List<MedicineModel>> searchProducts(String query) async {
    // Implement the search logic using Firestore queries
    // For example, you can use where() to filter by productName
    var snapshot = await FirebaseFirestore.instance
        .collection(medicineCollection)
        .where('productName', isGreaterThanOrEqualTo: query)
        .get();
    print(
        "${List<MedicineModel>.from(snapshot.docs.map((doc) => MedicineModel.fromDoc(doc)))}fromsearch");
    return List<MedicineModel>.from(
      snapshot.docs.map((doc) => MedicineModel.fromDoc(doc)),
    );
  }
}
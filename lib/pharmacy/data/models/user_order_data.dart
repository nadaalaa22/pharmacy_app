import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserOrderData {
  final  String userID,userName ,email ,phoneNumber , notes ;

  UserOrderData({required this.userID,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.notes});
  Map<String, dynamic> toMap() => {
    'userID':FirebaseAuth.instance.currentUser!.uid ,
    'userName': userName,
    'email': email,
    'phoneNumber': phoneNumber,
    'notes': notes,
  };

  factory UserOrderData.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserOrderData(
      userID: doc.data()['userID'],
      userName: doc.data()['userName'],
      email: doc.data()['email'],
      phoneNumber: doc.data()['phoneNumber'],
      notes: doc.data()['notes'],
    );
  }
}
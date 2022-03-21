import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

getCategoryData(String _collection){

  Stream<QuerySnapshot> _snapshot = FirebaseFirestore.instance.collection(_collection).snapshots();

  return _snapshot;

}

getDoctorData(String _collection, int _id) {
  Future<DocumentSnapshot<Map<String, dynamic>>> _snapshot = FirebaseFirestore.instance.collection(_collection).doc(_id.toString()).get();

  return _snapshot;
}
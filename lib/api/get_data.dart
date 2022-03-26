import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

getCategoryData(String _collection, {bool forMap = false}) {
  if(forMap == false){
    Stream<QuerySnapshot> _snapshot = FirebaseFirestore.instance.collection(_collection).snapshots();

    return _snapshot; 
  }else{
    Future<QuerySnapshot> _snapshot = FirebaseFirestore.instance.collection(_collection).get();

    return _snapshot;
  }
}

getDoctorData(String _collection, {int? id, bool lastId = false}) {
  if(lastId == false){
    Future<DocumentSnapshot<Map<String, dynamic>>> _snapshot = FirebaseFirestore.instance.collection(_collection).doc(id.toString()).get();

    return _snapshot;
  }else{
    Future<QuerySnapshot<Map<String, dynamic>>> _snapshot = FirebaseFirestore.instance.collection(_collection).get();

    return _snapshot;
  }
}
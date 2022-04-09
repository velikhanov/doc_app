import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Get all categories according to the user's role on the home page
getCategoryData(String _collection) async {
  QuerySnapshot<Map<String, dynamic>> _userRole = await FirebaseFirestore
      .instance
      .collection('roles')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> element in _userRole.docs) {
    if (element.data()['role'] == 'd') {
      Future<QuerySnapshot> _snapshot = FirebaseFirestore.instance
          .collection(_collection)
          .where('for_d', isEqualTo: true)
          .get();

      return _snapshot;
    } else if (element.data()['role'] == 'p') {
      Future<QuerySnapshot<Map<String, dynamic>>> _snapshot =
          FirebaseFirestore.instance.collection(_collection).get();

      return _snapshot;
    }
  }
}

// Mapping data for category selection on the registration page for doctors
getCategoriesSignUp(String _collection) {
  Future<QuerySnapshot<Map<String, dynamic>>> _snapshot =
      FirebaseFirestore.instance.collection(_collection).get();

  return _snapshot;
}

// Get doctor's details on his personal page
getDoctorData(String _collection, {int? id, bool lastId = false}) {
  if (lastId == false) {
    Future<DocumentSnapshot> _snapshot = FirebaseFirestore.instance
        .collection(_collection)
        .doc(id.toString())
        .get();

    return _snapshot;
  } else {
    Future<QuerySnapshot> _snapshot =
        FirebaseFirestore.instance.collection(_collection).get();

    return _snapshot;
  }
}

// Get user role (doctor or patient)
getUserRole(String _collection) {
  Future<QuerySnapshot> _snapshot =
      FirebaseFirestore.instance.collection(_collection).get();

  return _snapshot;
}

// Get visit history list

getVisitHistory(String _currentUser) async {
  QuerySnapshot<Map<String, dynamic>> _userRole = await FirebaseFirestore
      .instance
      .collection('roles')
      .where('uid', isEqualTo: _currentUser)
      .get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> element in _userRole.docs) {
    if (element.data()['role'] == 'p') {
      Future<QuerySnapshot> _snapshot = FirebaseFirestore.instance
          .collection('visit_history')
          .where('user_uid', isEqualTo: _currentUser)
          .get();

      return _snapshot;
    } else if(element.data()['role'] == 'd') {
      Future<QuerySnapshot> _snapshot = FirebaseFirestore.instance
          .collection('todays_appointments')
          .where('doc_uid', isEqualTo: _currentUser)
          .get();
          
      return _snapshot;
    }
  }
}

// Specific chat data
getChatMessages(String _collection) {
  Stream<QuerySnapshot<Map<String, dynamic>>> _snapshot = FirebaseFirestore
      .instance
      .collection(_collection)
      .orderBy('id_message', descending: true)
      .snapshots();
  return _snapshot;
}

// All patient/doctor chats
getChats(String _collection, String uid) async {
  QuerySnapshot<Map<String, dynamic>> _userRole = await FirebaseFirestore
      .instance
      .collection('roles')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> element in _userRole.docs) {
    if (element.data()['role'] == 'p') {
      QuerySnapshot<Map<String, dynamic>> _getMemberUid =
          await FirebaseFirestore.instance
              .collection(_collection)
              .where('member_1', isEqualTo: uid)
              .get();
      List _result = [];
      List _responce = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> el
          in _getMemberUid.docs) {
        QuerySnapshot<Map<String, dynamic>> _snapshot = await FirebaseFirestore
            .instance
            .collection('chats/' + uid + '/' + el.data()['member_2'])
            .orderBy('id_message', descending: false)
            .get();
        if (_snapshot.docs.isNotEmpty) {
          _result.add(_snapshot.docs.last.data());
        }
      }
      for (var _res in _result) {
        _responce.add(_res);
      }
      return _responce;
    } else if (element.data()['role'] == 'd') {
      QuerySnapshot<Map<String, dynamic>> _getMemberUid =
          await FirebaseFirestore.instance
              .collection(_collection)
              .where('member_2', isEqualTo: uid)
              .get();

      List _result = [];
      List _responce = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> el
          in _getMemberUid.docs) {
        QuerySnapshot<Map<String, dynamic>> _snapshot = await FirebaseFirestore
            .instance
            .collection('chats/' + el.data()['member_1'] + '/' + uid)
            .orderBy('id_message', descending: false)
            .get();

        if (_snapshot.docs.isNotEmpty) {
          _result.add(_snapshot.docs.last.data());
        }
      }
      for (var _res in _result) {
        _responce.add(_res);
      }
      return _responce;
    }
  }
}

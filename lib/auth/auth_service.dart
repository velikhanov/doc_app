import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  // Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<Object?> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      // return 'Signed in';
      return result.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<Object?> signUp(String email, String password,{bool isdoc = false, int categoryId = 1, String categoryName = 'Терапевт', int doctorId = 1, int userId = 1}) async {
    try {
      UserCredential _result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(_result.user!.uid.isNotEmpty){
        if(isdoc == true){
          DocumentReference<Map<String, dynamic>> _doctor = FirebaseFirestore.instance.collection('doctors/' + categoryId.toString() + '/' + categoryId.toString()).doc(doctorId.toString());
          _doctor.set({
            'category': categoryName,
            'id_category': categoryId.toInt(),
            'id_doctor': doctorId.toInt(),
            'email': email
          });
        }else{
          DocumentReference<Map<String, dynamic>> _user = FirebaseFirestore.instance.collection('users').doc(userId.toString());
          _user.set({
            'email': email,
            'user_id': userId
          });
        }
      }
      return _result.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
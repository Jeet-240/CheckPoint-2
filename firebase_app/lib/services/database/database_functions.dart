import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseDatabase init() {
  final databaseRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://jeet-first-firebase-default-rtdb.asia-southeast1.firebasedatabase.app/');
  return databaseRef;
}

void storeUserData({
  required String? userId,
  required String email,
  required String username,
})async {
  final databaseRef = init().ref('users/$userId');

  try{
    await databaseRef.set({
      'username' : username,
      'userId' : userId,
      'email' : email,
    });
  }catch(e){
    rethrow;
  }
}


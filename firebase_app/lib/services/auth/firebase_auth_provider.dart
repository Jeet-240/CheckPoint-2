import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_exceptions.dart';
import 'auth_provider.dart';
import 'auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart'
        show FirebaseAuth, FirebaseAuthException;
import '../database/database_functions.dart';


class FirebaseAuthProvide implements AuthProvider{
  @override
  Future<AuthUser> createUser({required String email, required String password,required String username}) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      final user = currentUser;
      if(user!=null){
        final userId = FirebaseAuth.instance.currentUser?.uid;
        storeUserData(userId: userId, email: email, username: username);
        return user;
      }else{
        throw UserNotLoggedInAuthException();
      }
    }on FirebaseAuthException catch(e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      }else if(e.code == 'too-many-requests'){
        throw TooManyRequest();
      } else if(e.code == 'network-request-failed'){
        throw NetworkRequestFailed();
      }
    }catch(e){
      throw GenericAuthException();}
    throw UserNotLoggedInAuthException();

  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser {
   final user = FirebaseAuth.instance.currentUser;
   if(user!=null){
     return AuthUser.fromFirebase(user);
   }else{
     return null;
   }
  }



  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,}) async{

      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
        );
        final user = currentUser;
        if(user!=null){
          return user;
        }else{
          throw UserNotLoggedInAuthException();
        }
      } on FirebaseAuthException catch(e){
        if (e.code == 'user-not-found') {
         throw UserNotFoundAuthException();
        } else if (e.code == 'wrong-password') {
          throw WrongPasswordAuthException();
        }else if(e.code == 'invalid-email'){
          throw InvalidAuthException();
        } else if(e.code == 'too-many-requests'){
          throw TooManyRequest();
        } else if(e.code == 'network-request-failed'){
          throw NetworkRequestFailed();
        }
      }catch(e){
        throw GenericAuthException();}

      throw UserNotLoggedInAuthException();

  }

  @override
  Future<void> logOut() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      await FirebaseAuth.instance.signOut();
    }else{
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      await user.sendEmailVerification();
    }else{
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> initialize() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

}
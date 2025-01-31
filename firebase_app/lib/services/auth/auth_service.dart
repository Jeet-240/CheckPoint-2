import 'package:firebase_app/services/auth/firebase_auth_provider.dart';
import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;

  AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvide());

  @override
  Future<AuthUser> createUser(
      { required String email,
        required String password,
        required String username}) => provider.createUser(
      email: email,
      password: password,
      username: username);

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn(
      {  required String email,
        required String password
      }) => provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() =>provider.initialize();

}
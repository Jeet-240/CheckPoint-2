import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/views/main_view.dart';
import 'package:firebase_app/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    color: Color.fromRGBO( 29, 22, 22  , 1),
    home:  HomePage(),
    routes: {
       '/login/' : (context)=> const LoginView(),
      '/register/' : (context) => const RegisterView(),
      '/home/' : (context) => const MainView(),
      '/verify/' : (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),

      builder: (context , snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done: {
            final user = FirebaseAuth.instance.currentUser;
            if(user!=null){
              if(!user.isAnonymous){
                if(!user.emailVerified){
                  return VerifyEmailView();
                }else{
                  return MainView();
                }
              }else{
                return LoginView();
              }
            }else{
              return LoginView();
            }
          }
          default:{
            return CircularProgressIndicator();
          }
        }
      },
    );
  }
}
















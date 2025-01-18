import 'package:firebase_app/services/auth/auth_service.dart';
import 'package:firebase_app/views/main_view.dart';
import 'package:firebase_app/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'constants/routes.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    color: Color.fromRGBO( 29, 22, 22  , 1),
    home:  HomePage(),
    routes: {
       loginRoute : (context)=> const LoginView(),
        registerRoute : (context) => const RegisterView(),
        mainRoute: (context) => const MainView(),
      verifyRoute : (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: AuthService.firebase().initialize(),
      builder: (context , snapshot){
        switch (snapshot.connectionState){
    case ConnectionState.done: {
            final user = AuthService.firebase().currentUser;
            if(user!=null){
            if(!user.isEmailVerified){
            return VerifyEmailView();
            }else{
            return MainView();
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
















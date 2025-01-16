import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/widgets/custom_button.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO( 29, 22, 22  ,  1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO( 142 , 22, 22  , 1),
        title: const Text(
            'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
      body: Column(
          children: [
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
              ),
            ),
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            CustomButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                print(email.trim());
                print(password.trim());
                await FirebaseAuth.instance.signOut();
                try {
                  final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: email.trim(),
                    password: password.trim(),
                  );
                  final user =  FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      print("Logged in as ${user.email}");
                      final isEmailVerified = user?.emailVerified ?? false;
                      if(!isEmailVerified){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/verify/", (route)=>false);
                      }else{
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home/',(route)=>false);
                      }
                    }
                    else {
                    print("Not logged in");
                  }
                  print(userCredential);
                }
                on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('USER NOT FOUND');
                  } else if (e.code == 'wrong-password') {
                    print('Entered Wrong Password');
                  }
                }
              },
              text: 'Login',
            ),
            CustomButton(
              onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/register/', (route)=>false
                  );
              },
              text: 'Not registered yet? Register Here!!',

            )
          ]
      ),
    );
  }
}
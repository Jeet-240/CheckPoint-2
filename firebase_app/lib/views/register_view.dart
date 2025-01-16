import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';



class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
    // TODO: implemenbot dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor:Color.fromRGBO( 29, 22, 22  ,  1),
       appBar: AppBar(
           backgroundColor: Color.fromRGBO( 142 , 22, 22  , 1),
           title: const Text(
           'Register',
         style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
         ),
       )),
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
                text: 'Register',
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: email,
                        password: password
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil('/verify/', (route)=>false);
                  } on FirebaseAuthException catch(e){
                    print("niggA + ${e.code}");
                    if(e.code == 'email-already-in-use'){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/login/"
                          , (route) => false);
                    }
                  }
                }
            ),
            CustomButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/login/"
                      , (route) => false);
                },
                text: 'Álready have an account? Login',
            ),
          ]
           ),
     );

  }
}



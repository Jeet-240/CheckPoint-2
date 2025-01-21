import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_dialogbox.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({super.key});

  @override
  State<WriteExamples> createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  late final TextEditingController _input;


  @override
  void initState() {
    // TODO: implement initState
    _input = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text('Write Examples'),),
      body: Center(
        child: Padding(
            padding: EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                controller: _input,
                decoration: const InputDecoration(
                  hintText: 'Enter something to upload',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              CustomButton(
                text: 'Click to submit',
                onPressed: () async {
                  print('Button Presseedddddd!!!');
                  // Initialize Firebase Database with proper URL
                  final ref = FirebaseDatabase.instanceFor(
                    app: Firebase.app(),
                      databaseURL: 'https://jeet-first-firebase-default-rtdb.asia-southeast1.firebasedatabase.app/'
                  ).ref();

                  // Get input and user email
                  final inputData = _input.text.trim();
                  var uid = FirebaseAuth.instance.currentUser?.uid;

                  // Handle null email (user not signed in)
                  if (uid == null) {
                    await showErrorDialog(context, 'User not signed in. Please log in.');
                    return;
                  }

                  // Format email for use as a key

                  // Validate input
                  if (inputData.isEmpty) {
                    await showErrorDialog(context, 'Enter something in the field');
                    return;
                  }

                  try {
                    // Use a unique path for each user's data
                    final userRef = ref.child('users/$uid');
                    // Write data
                    await userRef.update({"data" : inputData});
                    await showErrorDialog(context, 'Submitted!');
                  } catch (e) {
                    await showErrorDialog(context, 'Error: ${e.toString()}');
                  }
                },
              )

            ],
          ),
        ),
      ),

    );
  }
}



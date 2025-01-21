
import 'package:firebase_app/widgets/custom_button.dart';
import 'package:firebase_app/widgets/custom_dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class ReadExamples extends StatefulWidget {
  const ReadExamples({super.key});

  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {

  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Read Examples'),),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              CustomButton(
                  text: 'Click to get value',

                  onPressed:() async{
                    var uid = FirebaseAuth.instance.currentUser?.uid;
                    print('Pressed');
                    final ref = FirebaseDatabase.instanceFor(
                        app: Firebase.app(),
                        databaseURL: 'https://jeet-first-firebase-default-rtdb.asia-southeast1.firebasedatabase.app/'
                    ).ref('users/$uid');
                    try {
                      ref.onValue.listen((DatabaseEvent event) {
                        Object? obj = event.snapshot.value;
                        if(obj!=null && obj is Map){
                        String d = obj['data'] ?? "";
                        showErrorDialog(context, d);
                      }},
                      onError: (error){
                        showErrorDialog(context, 'error : ${error}');
                      });
                    }catch(e){
                      showErrorDialog(context, e.toString());
                    }
                  }
              ),
            ],
          ),
        ),
      ),

    );
  }
}

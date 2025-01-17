import 'package:firebase_app/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

enum MenuAction {logout}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor:Color.fromRGBO( 29, 22, 22  ,  1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(142, 22, 22  ,  1),
          title: const Text(
              'Main Page',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          ),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async{
                  switch (value){
                    case MenuAction.logout:
                      // TODO: Handle this case.
                      final shouldLogout = await showLogOutDialog(context);
                      if(shouldLogout){
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route)=>false);
                      }
                      break;
                  }

                },
              itemBuilder: (context){
                return [
                  const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log Out'),
                  )
                ];

              },
            )
          ],
        ),
        body: Image.asset('assets/images/loggedin.png'),
      ),
    );
  }
}



Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(context: context, builder: (context){
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        },
            child: const Text('Logout'),
        )
      ],
    );
  }
  ).then((value) => value ?? false);
}


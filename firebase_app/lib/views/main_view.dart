import 'package:firebase_app/constants/routes.dart';
import 'package:firebase_app/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/enums/menu_action.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/auth_exceptions.dart';



class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor:Color.fromRGBO( 29, 22, 22  ,  1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(142, 22, 22  ,  1),
          title:  Text(
              FirebaseAuth.instance.currentUser?.email ?? 'Hi',
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
                        try{
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        await AuthService.firebase().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route)=>false);
                        }
                      }break;
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
      backgroundColor: Colors.redAccent,
      title: const Text('Sign Out'),
      content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            fontWeight:  FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Roboto',
          )
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
          ),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight:  FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )
            ),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        },
            child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight:  FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )
            ),
        )
      ],
    );
  }
  ).then((value) => value ?? false);
}


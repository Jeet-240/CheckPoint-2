import 'package:flutter/material.dart';


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
        ),
        body: Image.asset('assets/images/loggedin.png'),
      ),
    );
  }
}

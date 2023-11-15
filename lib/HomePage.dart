import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;


  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: 
          [IconButton(icon:const Icon(Icons.logout),onPressed: signOut,)],
      ),
      body:  Center(
        child: Text("Logged In As:${user.email!}")
      ),
    );
  }
}
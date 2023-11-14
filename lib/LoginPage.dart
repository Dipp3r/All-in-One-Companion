import 'package:all_in_one/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{
    print(emailController.text);
    print(passwordController.text);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
    } catch(e){
      print("Handle error: $e");
    }
    // Navigator.of(context).push(MaterialPageRoute(builder: (context){
    //   return const HomePage();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Color.fromARGB(255, 95, 95, 95),)),
       
        actions: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color:Color.fromARGB(255, 180, 238, 255),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
              ),
              child: TextButton(
                onPressed: (){
                  signUserIn();
                }, 
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: const Color.fromARGB(149, 0, 0, 0),
                  backgroundColor:const Color.fromARGB(0, 168, 144, 255),         
                  shadowColor: Colors.white,
                  elevation: 0,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text("Login"),
                      Icon(Icons.arrow_forward_ios_rounded,size: 15),
                    ],
                  ),
                ),
              ),
            )
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: LoginForm(emailController: emailController,passwordController: passwordController,),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginForm({super.key, required this.emailController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20), 
        Image.asset("assets/time1.png",height: 250,width: 250,),
        const SizedBox(height: 20), 
        // Username Field
        TextFieldWidget(
          controller: emailController,
          label: 'Email',
          hintText: 'sample123@example.com',
        ),
        const SizedBox(height: 20), // Add some spacing between fields
        // Password Field
        TextFieldWidget(
          controller: passwordController,
          label: 'Password',
          hintText: 'random#890',
          isPassword: true,
        ),
        const SizedBox(height:30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?",),
            TextButton(onPressed: (){}, child: const Text("register",style: TextStyle(
              decoration: TextDecoration.underline,
            ),))
          ],
        ),
      ],
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const TextFieldWidget({super.key, 
    required this.label,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(255, 117, 117, 117),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
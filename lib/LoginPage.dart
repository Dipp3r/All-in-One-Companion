import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  final Function()? toggle;
  const LoginPage({super.key,required this.toggle});

  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {

  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{

    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator()
      );
    });
    try{
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      Navigator.pop(context);
      if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
        showError("Incorrect password or email");     
      } else if(e.code == 'invalid-email'){
        showError("Email entered is invalid");
      }
    }
    
  }

  void showError(String msg){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor:const Color.fromARGB(255, 212, 54, 54),
        icon: const Icon(Icons.error,color: Colors.white,size: 25,),
        title: Text(msg,style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w700
        ),),
      );
    });
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ 
                Image.asset("assets/time1.png",height: 250,width: 250,),
                LoginForm(emailController: emailController,passwordController: passwordController,),
                const SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",),
                    GestureDetector(
                      onTap:widget.toggle,
                      child: const Text("Register now",style: TextStyle(
                      decoration: TextDecoration.underline,
                      color:Color.fromARGB(255, 52, 115, 166),
                    ),)
                    )
                  ],
                ),
              ],
            ),
          ),
          
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
          hintText: 'pwd#890',
          isPassword: true,
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
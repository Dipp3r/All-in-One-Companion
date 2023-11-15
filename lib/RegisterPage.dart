import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  final Function()? toggle;
  const RegisterPage({super.key,required this.toggle});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async{

    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator()
      );
    });
    
      try{
        if(passwordController.text == confirmPasswordController.text){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text,
          );
          Navigator.pop(context);
        } else{
          Navigator.pop(context);
          showError("Passwords don't match"); 
        }
      } on FirebaseAuthException catch(e){
          Navigator.pop(context);
          print("ERROR ON FIREBASE"+e.code);
          if(e.code == 'weak-password'){
            showError("Password should be at least 6 characters");     
          } else if(e.code == 'invalid-email'){
            showError("Email entered is invalid");
          } else if(e.code == 'email-already-in-use'){
            showError("This email is already in use");
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
                color:Color.fromARGB(255, 118, 239, 182),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
              ),
              child: TextButton(
                onPressed: (){
                  signUserUp();
                }, 
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: const Color.fromARGB(149, 0, 0, 0),
                  backgroundColor:const Color.fromARGB(0, 168, 144, 255),         
                  shadowColor: Colors.white,
                  elevation: 0,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Text("Register"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/register.png",height: 300,width: 300,),
              Padding(
                padding: const EdgeInsets.only(left:30.0,right:30.0,bottom: 20.0),
                child: RegisterForm(emailController: emailController,passwordController: passwordController,confirmPasswordController: confirmPasswordController,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? ",),
                  GestureDetector(
                    onTap:widget.toggle,
                    child: const Text("Sign in",style: TextStyle(
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
    );
  }
}

class RegisterForm extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const RegisterForm({super.key, required this.emailController, required this.passwordController, required this.confirmPasswordController});

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
        const SizedBox(height: 20), // Add some spacing between fields
        // Password Field
        TextFieldWidget(
          controller: confirmPasswordController,
          label: 'Confirm Password',
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
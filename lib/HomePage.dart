import 'dart:ui';

import 'package:all_in_one/infoButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> splitString = FirebaseAuth.instance.currentUser!.email!.split('@');

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   shadowColor: const Color.fromARGB(255, 255, 255, 255),
      //   backgroundColor: Colors.white,
      //   elevation: 4.0,
      //   leading: Row(
      //     children: [
      //       IconButton(onPressed: (){}, icon:const Icon(Icons.menu)),
      //     ],
      //   ),
      //   actions: 
      //     [IconButton(icon:const Icon(Icons.logout),onPressed: signOut,)],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Stack(
              children:[ 
                Column(
                children: [
                  const SizedBox(height:20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Text("Welcome, ${splitString[0][0].toUpperCase()+splitString[0].substring(1)}",style:const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 46, 46, 46) ,
                            fontWeight: FontWeight.w900,
                          ),),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 46, 46, 46),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person,size: 25,color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:10),
                  Container(
                    color: Color.fromARGB(255, 222, 222, 222),
                    child: Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0,bottom:4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(5.0), 
                                      ),
                                      height: 150,
                                      width: MediaQuery.of(context).size.width/2-8+20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0,top:4.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: MediaQuery.of(context).size.width/2-8+20,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255),
                                            borderRadius: BorderRadius.circular(5.0), 
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/calc.png",height: 60,width: 60),
                                              const SizedBox(height:5),
                                              Text("Calculator",style: GoogleFonts.ptSans(
                                                fontSize: 20,
                                                color: const Color.fromARGB(255, 92, 92, 92),
                                                fontWeight: FontWeight.w600,
                                              ),),
                                            ],
                                          ),
                                        ),
                                        const InfoButton(msg: "Native Calculator: During work, you can quickly calculate project/daily expenses using the native calculator."),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                 height: 308,
                                  width: MediaQuery.of(context).size.width/2-16-20,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(5.0), 
                                  ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:8.0,left:8.0,bottom:8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width/2-8-30,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(5.0), 
                                  ),
                                ),
                              ),
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width/2-16+30,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(5.0), 
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:const Color.fromARGB(0, 255, 255, 255),
        elevation: 1,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(222, 36, 36, 36),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomBarButton(icon: Icons.home),
                  BottomBarButton(icon: Icons.alarm),
                  BottomBarButton(icon: Icons.newspaper),
                  BottomBarButton(icon: Icons.person),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarButton extends StatefulWidget {
  final IconData icon;

  const BottomBarButton({super.key, required this.icon});

  @override
  State<BottomBarButton> createState() => _BottomBarButtonState();
}

class _BottomBarButtonState extends State<BottomBarButton> {

  bool clicked = false;
  Color buttoncolor = Colors.white;
  double size = 25;

  void toggleColor(){
    setState(() {
      if(clicked){
        buttoncolor = Color.fromARGB(255, 183, 255, 238);
        size = 35;
      }else{
        size = 25;
        buttoncolor = Colors.white;
      }
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.icon, color: buttoncolor,size: size,),
      onPressed: () {
        // Handle button tap
        toggleColor();
      },
    );
  }
}
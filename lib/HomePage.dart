import 'dart:ui';

import 'package:all_in_one/RssFeed.dart';
import 'package:all_in_one/alarm.dart';
import 'package:all_in_one/calculator.dart';
import 'package:all_in_one/draw.dart';
import 'package:all_in_one/geoMap.dart';
import 'package:all_in_one/infoButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> splitString = FirebaseAuth.instance.currentUser!.email!.split('@');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void loadAlarmPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return const Alarm();
    }));
  }

  void loadNewsPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return const NewsApp();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                    child: Center(
                      child: Text(
                        'Profile',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(trailing: const Icon(Icons.notifications),
                    title: const Text('Notification'),
                    onTap: () {
                      // Handle item 1 tap
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Color.fromARGB(255, 98, 98, 98),
                  ),
                  ListTile(trailing: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Handle item 1 tap
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Color.fromARGB(255, 98, 98, 98),
                  ),
                  ListTile(trailing: const Icon(Icons.security),
                    title: const Text('Privacy & Security'),
                    onTap: () {
                      // Handle item 1 tap
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: Color.fromARGB(255, 98, 98, 98),
                  ),
                  // Add more items as needed
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin:const  EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 69, 60),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  trailing:const Icon(Icons.logout,color: Colors.white,),
                  title: const Text('Logout',style: TextStyle(
                    color: Colors.white,
                  ),),
                  onTap: () {
                    // Handle item 2 tap
                    FirebaseAuth.instance.signOut(); // Close the drawer
                  },
                ),
              ),
            ),
          ],
        ),
        
      ),
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
                          child: Text("Welcome, ${splitString[0][0].toUpperCase()+splitString[0].substring(1)}",style: GoogleFonts.pavanam(
                            fontSize: 28,
                            color: Color.fromARGB(255, 56, 56, 56) ,
                            fontWeight: FontWeight.bold,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:const Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                                return const DoodleApp();
                                              }));
                                            },
                                            child: Container(
                                            decoration: BoxDecoration(
                                              color:const Color.fromARGB(255, 18, 102, 63),
                                              borderRadius: BorderRadius.circular(5.0), 
                                            ),
                                            height: 150,
                                            width: MediaQuery.of(context).size.width/2-16+20,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/art.png",fit: BoxFit.fitWidth,),
                                                const SizedBox(height:5),
                                                Text("Doodle",style: GoogleFonts.aldrich(
                                                  fontSize: 20,
                                                  color:const Color.fromARGB(255, 255, 255, 255),
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InfoButton(msg: "Drawing Basic Graphical Primitives: Allows you to doodle and sketche using the app's drawing feature.",infoColor: Colors.white), 
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:8.0,top:4.0),
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                                return const CalculatorApp();
                                              }));
                                            },
                                            child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context).size.width/2-16+20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(5.0), 
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset("assets/calc.png",height: 60,width: 60),
                                                  const SizedBox(height:5),
                                                  Text("Calculator",style: GoogleFonts.aldrich(
                                                    fontSize: 20,
                                                    color: const Color.fromARGB(255, 92, 92, 92),
                                                    fontWeight: FontWeight.w600,
                                                  ),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InfoButton(msg: "Native Calculator: During work, you can quickly calculate project/daily expenses using the native calculator.",infoColor: const Color.fromARGB(255, 128, 128, 128),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                          return const MyLocation();
                                        }));
                                      },
                                      child: Container(
                                       height: 308,
                                        width: MediaQuery.of(context).size.width/2-24-20,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 255, 99, 42),
                                          borderRadius: BorderRadius.circular(5.0), 
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/coffee.jpeg",fit: BoxFit.fitWidth,),
                                            Text("Coffee",style: GoogleFonts.aldrich(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  InfoButton(msg: "Use the app's built-in map to find the nearest coffee shop using GPS.",infoColor: Colors.white),
                                  ],
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
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                            return const Alarm();
                                          }));
                                        },
                                        child: Container(
                                        height: 150,
                                        width: MediaQuery.of(context).size.width/2-16-30,
                                        decoration: BoxDecoration(
                                          color:const Color.fromARGB(255, 223, 235, 211),                                 borderRadius: BorderRadius.circular(5.0), 
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/alarm.png",fit: BoxFit.fitWidth,),
                                            Text("Alarm",style: GoogleFonts.aldrich(
                                              fontSize: 20,
                                              color:const Color.fromARGB(255, 83, 83, 83),
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          ],
                                        ),
                                                                          ),
                                      ),
                                    InfoButton(msg: "Set a personalized alarm to wake up at a desired time.",infoColor: const Color.fromARGB(255, 83, 83, 83),),  
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                          return const NewsApp();
                                        }));
                                      },
                                      child: Container(
                                        height: 150,
                                        width: MediaQuery.of(context).size.width/2-24+30,
                                        decoration: BoxDecoration(
                                          color:const Color.fromARGB(255, 148, 148, 148),
                                          borderRadius: BorderRadius.circular(5.0), 
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/feed.png",height: 100,width: 100),
                                            Text("Feed",style: GoogleFonts.aldrich(
                                              fontSize: 20,
                                              color:const Color.fromARGB(255, 255, 255, 255),
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),  
                                    InfoButton(msg: "RSS Feed : Browse the latest news articles fetched through the app's integrated RSS feed.",infoColor: Colors.white,), 
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                color: const Color.fromARGB(222, 36, 36, 36),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: BottomBar(onPersonTap: _openDrawer,onAlarmTap: () => loadAlarmPage(context),onNewsTap: () => loadNewsPage(context)),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  final VoidCallback? onPersonTap;
  final VoidCallback? onAlarmTap;
  final VoidCallback? onNewsTap;
  const BottomBar({super.key,  this.onPersonTap,  this.onAlarmTap,  this.onNewsTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = -1;

  void _handleTap(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1; // Reset the color if the same button is tapped
      } else {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BottomBarButton(
          icon: Icons.alarm,
          onTap: () {_handleTap(0); widget.onAlarmTap!();},
          isSelected: selectedIndex == 0,
        ),
        BottomBarButton(
          icon: Icons.newspaper,
          onTap: () { _handleTap(1); widget.onNewsTap!();},
          isSelected: selectedIndex == 1,
        ),
        BottomBarButton(
          icon: Icons.person,
          onTap: () {_handleTap(2); widget.onPersonTap!();},
          isSelected: selectedIndex == 2,
        ),
      ],
    );
  }
}


class BottomBarButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isSelected ;
  

  const BottomBarButton({super.key, required this.icon, this.onTap, required this.isSelected});

  @override
  State<BottomBarButton> createState() => _BottomBarButtonState();
}

class _BottomBarButtonState extends State<BottomBarButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.icon, color: widget.isSelected?const Color.fromARGB(255, 183, 255, 238):Colors.white,size: 25,),
      onPressed: () {
        // Handle button tap
        widget.onTap!();
      },
    );
  }
}

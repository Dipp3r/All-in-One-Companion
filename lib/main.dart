import 'package:all_in_one/HomePage.dart';
import 'package:all_in_one/LoginOrSignupPage.dart';
import 'package:all_in_one/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  Logger.level = Level.error;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const First(),
    );
  }
}


class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color:Color.fromARGB(200, 168, 144, 255), 
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const AuthPage();
                  }));
                }, 
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: const Color.fromARGB(149, 0, 0, 0),
                  backgroundColor:const Color.fromARGB(0, 168, 144, 255),         
                  shadowColor: Colors.white,
                  elevation: 0,
                ),
                icon:const Icon(Icons.arrow_forward_ios_rounded,size: 20,),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(    
              children: [
                const SizedBox(height: 10),
                const Column(
                  children: [
                    Text("All-in-One",style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(205, 47, 81, 109),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'San Francisco',
                    ),),
                    Text("Companion",style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(162, 47, 81, 109),
                      fontWeight: FontWeight.w800,
                      fontFamily: 'San Francisco',
                    ),),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset("assets/yoga.jpg",height: 250,width: 250),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(138, 192, 235, 174),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Column(
                      children: [
                        Text("Unlock the power of Seamless Living with 'All-in-One Companion'-",style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(227, 52, 52, 52),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'San Francisco',
                        ),),
                        Text("Your Ultimate Sidekick for a Day of Effortless Productivity, Endless Entermainment, and Unmatched Connectivity. From sunrise to sunsent, this cersatile app is your gateway to a world where every task, every moment, and every connection is effortlessly enhanced. Streamline your life, embrace productivity, and reveal in the joy of an all-encompassing companion that adapts to your every need. Your day jusy got a whole lot smoother!",style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(218, 94, 94, 94),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'San Francisco',
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          //user is logged in
          if(snapshot.hasData){
            return HomePage();
          }
          //user is not logged in
          else{
            return const LoginOrSignupPage();
          }
        },
      )
    );
  }
}
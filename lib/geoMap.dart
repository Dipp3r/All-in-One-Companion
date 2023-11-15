import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyLocation extends StatefulWidget {
  
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  String latitude='unknown';
  String longitude='unknown';

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }

    if(permission==LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied, we cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation(){
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    });
  }

  Future<void> _openMap(String lat,String long) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    try{
      await launchUrl(Uri.parse(googleUrl)); 
    }catch(e){
      throw 'Could not launch $googleUrl, dude to ${e}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Near Me'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Image.asset("assets/maps.jpeg")
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap:(){
                _openMap(latitude,longitude);
              },
              child: const Icon(Icons.location_pin,size:80,color: Color.fromARGB(255, 225, 57, 45)
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Longitude: ",style: GoogleFonts.mako(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                )),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(5),
                  margin:const  EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text(longitude)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Latitude: ",style: GoogleFonts.mako(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                )),
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(5),
                  margin:const  EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text(latitude)),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor:const Color.fromARGB(255, 225, 57, 45),onPressed: (){
        _getCurrentLocation().then((value){
          setState(() {
            latitude = '${value?.latitude}';
            longitude = '${value?.longitude}';
          });
          _liveLocation();
        });
      },child:const Icon(Icons.location_history,color: Colors.white),),
    );
  }
}
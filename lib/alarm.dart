import 'dart:async';
import 'package:all_in_one/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Alarm extends StatefulWidget {
  const Alarm({super.key});
  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  late String hour;
  late String minute;
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios,size: 20,)),
        title: const Text('Wakie-Wakie'),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Clock"),
              const Clock(),
              const Divider(thickness: 2,color: Colors.black),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Alarm",style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 42, 42, 42),
                  ),),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true, // Ensure the ListView doesn't take more space than needed
                      physics: const NeverScrollableScrollPhysics(),  
                      itemCount: alarms.length+1, // Specify the itemCount
                      itemBuilder: (context, index) {
                        if(index<alarms.length){
                          var alarm = alarms[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 4,
                                  offset: const Offset(4, 4),
                                )
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 252, 126, 117),
                                  Color.fromARGB(255, 183, 110, 196),
                                  Color.fromARGB(255, 102, 164, 215),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.label,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        const SizedBox(width:8),
                                        Text(alarm.description,style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      ],
                                    ),
                                    Switch(
                                      value: true, 
                                      onChanged: (bool value){

                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Text(
                                  'Mon-Fri',
                                  style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '07:00 AM',
                                      style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    const Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 35),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          return GestureDetector(
                            onTap: (){
                              print("add new alarm");
                            },
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              child: DottedBorder(
                                strokeWidth: 3,
                                color:const Color.fromARGB(255, 141, 141, 141),
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                dashPattern: const [5,4],
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:const Color.fromARGB(120, 200, 200, 200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(Icons.add_alarm,size: 50,color: Color.fromARGB(255, 55, 55, 55),),
                                      Text("Add Alarm",style: GoogleFonts.dmSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(255, 71, 71, 71),
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    // Update the time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Text(
          _formatTime(_currentTime),
          style: GoogleFonts.roboto(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 71, 71, 71),
          ),
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    // Format the time as HH:MM:SS
    if(time.minute<10){
      return '${time.hour}:0${time.minute}'; 
    }
    return '${time.hour}:${time.minute}';
  }
}

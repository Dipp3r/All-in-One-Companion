import 'dart:async';
import 'package:all_in_one/alarm_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  
  // var now = DateTime.now();

  TextEditingController inputLabel = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final CollectionReference _alarmsCollection = FirebaseFirestore.instance.collection('alarms');
  bool switchState = true;


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

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
                  FutureBuilder<QuerySnapshot>(
                    future: _alarmsCollection.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child:  CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {

                        // Process the documents and filter out the ones that belong the current user
                        final List<DocumentSnapshot> documents = snapshot.data!.docs
                        .where((alarm) => alarm['userid']==FirebaseAuth.instance.currentUser!.uid).toList();

                        // Do something with the documents
                        // For example, print document data
                        for (var document in documents) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          print('Data: ${data['label']}');
                        }

                        return Flexible(
                          child: ListView.builder(
                            shrinkWrap: true, // Ensure the ListView doesn't take more space than needed
                            physics: const NeverScrollableScrollPhysics(),  
                            itemCount: documents.length+1, // Specify the itemCount
                            itemBuilder: (context, index) {
                              if(index<documents.length){
                                var alarm = documents[index].data() as Map<String,dynamic>;
                                
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
                                              Text(alarm['label'],style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),),
                                            ],
                                          ),
                                          Switch(
                                            value: alarm['isPending'], 
                                            onChanged: (bool value) async {  
                                              await updateAlarmIsPending(alarm['id'], !alarm['isPending']);
                                              setState(() {
                                                
                                              });
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
                                            alarm['time'],
                                            style: GoogleFonts.dmSans(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                          GestureDetector(
                                            onTap:() async {
                                              await deleteAlarmIsPending(alarm['id']);
                                              setState(() {
                                                
                                              });
                                            },
                                            child: const Icon(Icons.delete,color: Colors.white,size: 25)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              else{
                                return GestureDetector(
                                  onTap: (){
                                    String label = inputLabel.text;
                                    String time = _selectedTime.format(context);
                                    print('THE OUTPUT OF THE CLICK ::::: label: ${inputLabel.text}, time: ${_selectedTime.format(context)}');
                                    createAlarm(label:label,time:time,isPending:true);
                                    setState(() {
                                      _selectedTime = TimeOfDay.now();
                                      inputLabel = TextEditingController();
                                    });
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  height: 30,
                                                  child:  TextField(
                                                    controller: inputLabel,
                                                    decoration: const InputDecoration(
                                                      hintText: 'label',
                                                      contentPadding: EdgeInsets.only(left:10),
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                    foregroundColor: const Color.fromARGB(255, 73, 73, 73),
                                                  ),
                                                  onPressed: () => _selectTime(context),
                                                  child: Text(_selectedTime.format(context)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                        // Display the data in a widge
                      }
                    },
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createAlarm({required String label,required String time,required bool isPending}) async {
    final docAlarm = FirebaseFirestore.instance.collection('alarms').doc();

    final alarm = AlarmDoc(
      userid:FirebaseAuth.instance.currentUser!.uid,
      id:docAlarm.id,
      label:label,
      isPending:isPending,
      time:time
    );
    
    final json = alarm.toJson();
    await docAlarm.set(json);
  }

  Future<void> updateAlarmIsPending(String alarmId, bool newIsPending) async {
  CollectionReference alarmsCollection = FirebaseFirestore.instance.collection('alarms');
  
  try {
    // Get the document reference for the specific alarm
    DocumentReference alarmDocRef = alarmsCollection.doc(alarmId);
    
    // Update the 'isPending' field
    await alarmDocRef.update({'isPending': newIsPending});
    print('Document with ID $alarmId updated successfully.');
  } catch (e) {
    print('Error updating document: $e');
    // Handle the error as needed
  }
}

  Future<void> deleteAlarmIsPending(String alarmId) async {
  CollectionReference alarmsCollection = FirebaseFirestore.instance.collection('alarms');
  
  try {
    // Get the document reference for the specific alarm
    DocumentReference alarmDocRef = alarmsCollection.doc(alarmId);
    
    // Update the 'isPending' field
    await alarmDocRef.delete();
    print('Document with ID $alarmId deleted successfully.');
  } catch (e) {
    print('Error updating document: $e');
    // Handle the error as needed
  }
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
    String hour = time.hour<10 ? '0${time.hour}' : '${time.hour}';
    String minute = time.minute<10 ? '0${time.minute}' : '${time.minute}'; 
    return '$hour:$minute';
  }
}



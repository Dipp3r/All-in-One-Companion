import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key, required this.msg});

  void showInfo(BuildContext context, String msg){
    print("BUTTON ENTEREDDDD");
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor:Color.fromARGB(255, 78, 78, 78),icon: const Icon(Icons.error,color: Colors.white,size: 25,),
        title: Padding(
          padding: const EdgeInsets.only(top:12.0,bottom:12),
          child: Text(msg,style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
            fontWeight: FontWeight.w700
          ),),
        ),
      );
    });
  }
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -5,
      right: -5,
      child: IconButton(onPressed: (){
        showInfo(context,msg);
      },icon: const Icon(Icons.info,color: Color.fromARGB(255, 128, 128, 128),),
      ));
  }
}

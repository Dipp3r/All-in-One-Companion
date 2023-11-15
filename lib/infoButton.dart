import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  InfoButton({super.key, required this.msg, required this.infoColor});

  void showInfo(BuildContext context, String msg){
    print("BUTTON ENTEREDDDD");
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor:const Color.fromARGB(255, 37, 37, 37),icon: const Icon(Icons.error,color: Colors.white,size: 25,),
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
  Color infoColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -5,
      right: -5,
      child: IconButton(onPressed: (){
        showInfo(context,msg);
      },icon: Icon(Icons.info,color: infoColor,),
      ));
  }
}

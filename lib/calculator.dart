import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Calculator"),
      ),
      body: const CalculatorScreen(),
    );
  }
}


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _num1 = 0;
        _num2 = 0;
        _operand = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        try{
          _num1 = double.parse(_output);
          _operand = buttonText;
          _output = (_num1).toString() + _operand;
          print("output  = ${_output} operand = ${_operand} num1 = ${_num1} num2 = ${_num2}");
        } catch(e){
            try{
              _num1 = double.parse(_output.substring(0,_output.indexOf(_operand)-1));
              _num2 = double.parse(_output.substring(_output.indexOf(_operand) + 1, _output.length));
              _output = '';
              if (_operand == '+') {
                _output = (_num1 + _num2).toString();
              }
              if (_operand == '-') {
                _output = (_num1 - _num2).toString();
              }
              if (_operand == '*') {
                _output = (_num1 * _num2).toString();
              }
              if (_operand == '/') {
                _output = (_num1 / _num2).toStringAsFixed(2);
              } 
              _operand = buttonText;
              _output += _operand;
              print("output  = ${_output} operand = ${_operand} num1 = ${_num1} num2 = ${_num2}");
            }catch(e){
              print(e);
            }
        }
       
      } else if (buttonText == '=') {
      try{
          _num2 = double.parse(_output.substring(_output.indexOf(_operand) + 1, _output.length));
          _output = '';
          if (_operand == '+') {
            _output = (_num1 + _num2).toString();
          }
          if (_operand == '-') {
            _output = (_num1 - _num2).toString();
          }
          if (_operand == '*') {
            _output = (_num1 * _num2).toString();
          }
          if (_operand == '/') {
            _output = (_num1 / _num2).toStringAsFixed(2);
          }
          _num1 = 0;
          _num2 = 0;
          _operand = '';
        }catch(e){};
        
        print("output  = ${_output} operand = ${_operand} num1 = ${_num1} num2 = ${_num2}");
      } else {
        _output += double.parse(buttonText).toString();
        print("output  = ${_output} operand = ${_operand} num1 = ${_num1} num2 = ${_num2}");
      }
    });
  }

  Widget _buildButton(
    String buttonText,
    Color buttonColor,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons
          .map((button) => _buildButton(
                button,
                button == '=' || button == '/' || button == '*' || button == '-' || button == '+'
                    ? Colors.amber
                    :const Color.fromARGB(255, 101, 101, 101),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(24.0),
            child: Text(
              _output,
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
        const Divider(height: 10.0,thickness: 3,color: Color.fromARGB(255, 78, 78, 78),),
        Column(
          children: [
            _buildButtonRow(['7', '8', '9', '/']),
            _buildButtonRow(['4', '5', '6', '*']),
            _buildButtonRow(['1', '2', '3', '-']),
            _buildButtonRow(['C', '0', '=', '+', '.']),
          ],
        ),
      ],
    );
  }
}

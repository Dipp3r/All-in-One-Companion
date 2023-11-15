import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DoodleApp extends StatefulWidget {
  const DoodleApp({super.key});

  @override
  State<DoodleApp> createState() => _DoodleAppState();
}
class _DoodleAppState extends State<DoodleApp> {
  String selectedShape = 'circle';
  final TextEditingController _stroke = TextEditingController();
  final TextEditingController _radius = TextEditingController();
  final TextEditingController _x1 = TextEditingController();
  final TextEditingController _x2 = TextEditingController();
  final TextEditingController _y1 = TextEditingController();
  final TextEditingController _y2 = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color.fromARGB(255, 38, 186, 77);
  List<ShapeData> shapes = []; // List to store shapes data

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void showpallet(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    });
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: const Text('Graphics tool'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: DropdownButton<String>(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 25, 87, 138),
                      fontSize: 16,
                    ),
                    items: const <String>['circle', 'rectangle', 'line'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedShape = newValue!;
                      });
                    },
                    value: selectedShape,
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: TextField(
                    controller: _stroke,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Stroke',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 30,
                  child: TextField(
                    controller: _x1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Initial x',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 30,
                  child: TextField(
                    controller: _y1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Initial y',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 65,
                  height: 30,
                  child: TextField(
                    controller: _x2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Final x',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  height: 30,
                  child: TextField(
                    controller: _y2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Final y',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 30,
                  child: TextField(
                    controller: _radius,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Radius',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  showpallet();
                },style: ElevatedButton.styleFrom(
                  backgroundColor: currentColor,
                  foregroundColor: Colors.white,
                ), child: const Text("Color"))
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaint(
                painter: ShapesPainter(shapes: shapes),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 300,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(205, 168, 111, 206), width: 8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    addShape(); // Call a function to add the shape
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addShape() {
    setState(() {
      shapes.add(ShapeData(
        shapeType: selectedShape,
        strokeWidth: double.parse(_stroke.text),
        shapeColor: currentColor,
        initialx:double.parse(_x1.text),
        initialy:double.parse(_y1.text),
        finalx:double.parse(_x2.text),
        finaly:double.parse(_y2.text),
        radius:double.parse(_radius.text),
      ));
    });
  }

  @override
  void dispose() {
    _stroke.dispose(); // Dispose the TextEditingController to avoid memory leaks
    super.dispose();
  }
}

class ShapesPainter extends CustomPainter {
  final List<ShapeData> shapes;

  ShapesPainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var shapeData in shapes) {
      final paint = Paint()
        ..color = shapeData.shapeColor
        ..strokeWidth = shapeData.strokeWidth
        ..style = PaintingStyle.stroke;

      if (shapeData.shapeType == 'rectangle') {
        Rect rect = Rect.fromPoints(Offset(shapeData.initialx, shapeData.initialy), Offset(shapeData.finalx, shapeData.finaly));
        canvas.drawRect(rect, paint);
      } else if (shapeData.shapeType == 'circle') {
        canvas.drawCircle(Offset(shapeData.initialx, shapeData.initialy),shapeData.radius, paint);
      } else if (shapeData.shapeType == 'line') {
        canvas.drawLine(Offset(shapeData.initialx, shapeData.initialy), Offset(shapeData.finalx, shapeData.finaly), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ShapeData {
  final String shapeType;
  final double strokeWidth;
  final Color shapeColor;
  final double initialx;
  final double initialy;
  final double finalx;
  final double finaly;
  final double radius;
  
  ShapeData({required this.shapeColor,required this.initialx,required this.initialy,required this.finalx,required this.finaly,required this.radius, required this.shapeType, required this.strokeWidth});
}


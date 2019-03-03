import 'package:flutter/material.dart';


import 'dart:async';
import 'package:icu/icu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Grapheme cluster testing')),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final ICUString icuText = ICUString('Let me introduce my \u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467} to you.\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467}');
  TextEditingController controller;
  _BodyWidgetState() {
    controller = TextEditingController(
      text: icuText.toString()
  );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('<<'),
                onPressed: () async {
                  await _moveCursorLeft();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('>>'),
                onPressed: () async {
                  await _moveCursorRight();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void _moveCursorLeft() async {
    int currentCursorPosition = controller.selection.start;
    if (currentCursorPosition == 0)
      return;
    int newPosition = await icuText.previousGraphemePosition(currentCursorPosition);
    controller.selection = TextSelection(baseOffset: newPosition, extentOffset: newPosition);
  }

  void _moveCursorRight() async {
    int currentCursorPosition = controller.selection.end;
    if (currentCursorPosition == controller.text.length)
      return;
    int newPosition = await icuText.nextGraphemePosition(currentCursorPosition);
    print("newPosition $newPosition");
    controller.selection = TextSelection(baseOffset: newPosition, extentOffset: newPosition);
  }
}

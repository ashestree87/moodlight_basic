import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _currentColor = Colors.red;
  Color _nextColor = Colors.green;
  int _transitionDuration = 10;
  bool _inTransition = false;

  @override
  void initState() {
    super.initState();
    _startTransition();
    // Hide the status bar and make the app full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    _stopTransition();
    // Show the status bar when the app is closed or destroyed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void _startTransition() {
    _inTransition = true;
    _nextColor = _getRandomColor();
    Timer(Duration(seconds: _transitionDuration), () {
      if (mounted) {
        setState(() {
          _currentColor = _nextColor;
        });
        _startTransition();
      }
    });
  }

  void _stopTransition() {
    _inTransition = false;
  }

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _currentColor,
        body: Center(
          child: AnimatedOpacity(
            duration: Duration(seconds: _transitionDuration),
            opacity: _inTransition ? 0.3 : 1.0,
            child: const Text(
              '',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

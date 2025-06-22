import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      debugShowCheckedModeBanner: false,
      home: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  StopwatchPage();

  @override
  State<StopwatchPage> createState() => StopwatchState();
}

class StopwatchState extends State<StopwatchPage> {
  int seconds = 0;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    setState(() {
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          seconds++;
        });
      });
      isRunning = true;
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⏱ Stopwatch App'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatTime(seconds),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    label: 'Start',
                    onPressed: isRunning ? null : startTimer,
                    color: Colors.green,
                  ),
                  SizedBox(width: 20),
                  _buildButton(
                    label: 'Stop',
                    onPressed: isRunning ? stopTimer : null,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 20),
                  _buildButton(
                    label: 'Reset',
                    onPressed: resetTimer,
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ? Colors.grey[400] : color,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: Text(label.toUpperCase()),
    );
  }
}

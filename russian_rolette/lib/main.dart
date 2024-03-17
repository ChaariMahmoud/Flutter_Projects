import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(RussianRouletteApp());

class RussianRouletteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Russian Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RussianRouletteScreen(),
    );
  }
}

class RussianRouletteScreen extends StatefulWidget {
  @override
  _RussianRouletteScreenState createState() => _RussianRouletteScreenState();
}

class _RussianRouletteScreenState extends State<RussianRouletteScreen> {
  bool _isBulletLoaded = false;
  bool _isSpinning = false;

  void _spinChamber() {
    if (!_isSpinning) {
      setState(() {
        _isSpinning = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isBulletLoaded = Random().nextBool();
          _isSpinning = false;
        });
      });
    }
  }

  void _fire() {
    if (!_isSpinning) {
      setState(() {
        if (_isBulletLoaded) {
          _showGameOverDialog();
        } else {
          _showWinDialog();
        }
      });
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You fired a loaded chamber!'),
          actions: <Widget>[
            TextButton(
              child: Text('Try Again'),
              onPressed: () {
                _spinChamber();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations'),
          content: Text('You survived!'),
          actions: <Widget>[
           TextButton(
              child: Text('Spin Again'),
              onPressed: () {
                _spinChamber();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Russian Roulette'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/roulette.png'),
                  fit: BoxFit.cover,
                ),
              ),
              transform: Matrix4.rotationZ(_isSpinning ? pi / 2 : 0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinChamber,
              child: Text('Spin Chamber'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fire,
              child: Text('Fire'),
            ),
          ],
        ),
      ),
    );
  }
}

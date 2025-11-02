import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _firstNumber = 0;
  String _operation = '';
  bool _isNewNumber = true;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _firstNumber = 0;
        _operation = '';
        _isNewNumber = true;
      } else if (['+', '-', '*', '/'].contains(value)) {
        _firstNumber = double.parse(_display);
        _operation = value;
        _isNewNumber = true;
      } else if (value == '=') {
        double secondNumber = double.parse(_display);
        double result = 0;
        if (_operation == '/' && secondNumber == 0) {
          _display = 'Error';
          _firstNumber = 0;
          _operation = '';
          _isNewNumber = true;
        } else {
          switch (_operation) {
            case '+':
              result = _firstNumber + secondNumber;
              break;
            case '-':
              result = _firstNumber - secondNumber;
              break;
            case '*':
              result = _firstNumber * secondNumber;
              break;
            case '/':
              result = _firstNumber / secondNumber;
              break;
          }
          _display = result % 1 == 0 ? result.toInt().toString() : result.toString();
          _operation = '';
          _isNewNumber = true;
        }
      } else {
        if (_isNewNumber) {
          _display = value;
          _isNewNumber = false;
        } else {
          _display = _display == '0' ? value : _display + value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Button grid
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: [
                    _buildButton(context, 'C', Colors.red[300]!),
                    ...['7', '8', '9', '4', '5', '6', '1', '2', '3', '0']
                        .map((number) => _buildButton(context, number, Colors.grey[300]!)),
                    _buildButton(context, '+', Colors.orange[200]!),
                    _buildButton(context, '-', Colors.orange[200]!),
                    _buildButton(context, '*', Colors.orange[200]!),
                    _buildButton(context, '/', Colors.orange[200]!),
                    _buildButton(context, '=', Colors.green[300]!, colSpan: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, {int colSpan = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        onPressed: () => _onButtonPressed(text),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
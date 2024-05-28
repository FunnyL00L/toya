// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';

  void _inputDigit(String digit) {
    setState(() {
      if (_display == '0') {
        _display = digit;
      } else {
        _display += digit;
      }
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      _firstOperand = double.parse(_display);
      _display = '0';
      _operator = operator;
    });
  }

  void _calculateResult() {
    setState(() {
      _secondOperand = double.parse(_display);
      switch (_operator) {
        case '+':
          _display = (_firstOperand + _secondOperand).toString();
          break;
        case '-':
          _display = (_firstOperand - _secondOperand).toString();
          break;
        case '*':
          _display = (_firstOperand * _secondOperand).toString();
          break;
        case '/':
          _display = (_firstOperand / _secondOperand).toString();
          break;
      }
      _operator = '';
      _firstOperand = 0;
      _secondOperand = 0;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
    });
  }

  Widget _buildButton(String text, Color color, void Function() onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(fontSize: 24)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Text(_display, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7', Colors.grey, () => _inputDigit('7')),
              _buildButton('8', Colors.grey, () => _inputDigit('8')),
              _buildButton('9', Colors.grey, () => _inputDigit('9')),
              _buildButton('/', Colors.orange, () => _inputOperator('/')),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', Colors.grey, () => _inputDigit('4')),
              _buildButton('5', Colors.grey, () => _inputDigit('5')),
              _buildButton('6', Colors.grey, () => _inputDigit('6')),
              _buildButton('*', Colors.orange, () => _inputOperator('*')),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', Colors.grey, () => _inputDigit('1')),
              _buildButton('2', Colors.grey, () => _inputDigit('2')),
              _buildButton('3', Colors.grey, () => _inputDigit('3')),
              _buildButton('-', Colors.orange, () => _inputOperator('-')),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', Colors.grey, () => _inputDigit('0')),
              _buildButton('C', Colors.grey, _clear),
              _buildButton('=', Colors.orange, _calculateResult),
              _buildButton('+', Colors.orange, () => _inputOperator('+')),
            ],
          ),
        ],
      ),
    );
  }
}

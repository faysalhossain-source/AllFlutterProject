import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
      } else if (buttonText == "⌫") {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          _output = _currentInput.isEmpty ? "0" : _currentInput;
        }
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "÷") {
        if (_currentInput.isNotEmpty) {
          _num1 = double.tryParse(_currentInput) ?? 0;
          _operation = buttonText;
          _currentInput = "";
          _output = "$_num1 $_operation";
        }
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _operation.isNotEmpty) {
          _num2 = double.tryParse(_currentInput) ?? 0;
          switch (_operation) {
            case "+":
              _currentInput = (_num1 + _num2).toString();
              break;
            case "-":
              _currentInput = (_num1 - _num2).toString();
              break;
            case "x":
              _currentInput = (_num1 * _num2).toString();
              break;
            case "÷":
              _currentInput =
              _num2 != 0 ? (_num1 / _num2).toStringAsFixed(2) : "Error";
              break;
          }
          _num1 = 0;
          _num2 = 0;
          _operation = "";
          _output = _currentInput;
        }
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput += buttonText;
          _output = _currentInput;
        }
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String buttonText,
      {Color color = Colors.white, Color textColor = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 28.0, color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding:
            const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                _output,
                style: const TextStyle(
                    fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    _buildButton("⌫", color: Colors.grey.shade300),
                    _buildButton("%"),
                    _buildButton(""),
                    _buildButton(""),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("÷",
                        color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("x",
                        color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-",
                        color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("C", color: Colors.red, textColor: Colors.white),
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("+",
                        color: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () => _buttonPressed("="),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "=",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

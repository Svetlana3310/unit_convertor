import 'package:flutter/material.dart';
import 'conversion_logic.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  double _result = 0;
  String _selectedCategory = 'Length';
  String _fromUnit = 'Inches';
  String _toUnit = 'Centimeters';

  final Map<String, List<String>> _units = {
    'Length': ['Inches', 'Centimeters'],
    'Square': ['Acres', 'Hectares'],
    'Weight': ['Kilograms', 'Pounds'],
    'Volume': ['Liters', 'Gallons'],
    'Distance': ['Kilometers', 'Miles'],
  };

  final Map<String, String> _defaultToUnits = {
    'Inches': 'Centimeters',
    'Centimeters': 'Inches',
    'Acres': 'Hectares',
    'Hectares': 'Acres',
    'Kilograms': 'Pounds',
    'Pounds': 'Kilograms',
    'Liters': 'Gallons',
    'Gallons': 'Liters',
    'Kilometers': 'Miles',
    'Miles': 'Kilometers',
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0;
      _result = convertUnits(_fromUnit, _toUnit, input);
    });
  }

  void _updateUnits(String selectedUnit, bool isFromUnit) {
    setState(() {
      if (isFromUnit) {
        _fromUnit = selectedUnit;
        _toUnit = _defaultToUnits[selectedUnit]!;
      } else {
        _toUnit = selectedUnit;
        _fromUnit = _defaultToUnits[selectedUnit]!;
      }
      if (_controller.text.isNotEmpty) {
        _convert();
      }
    });
  }

  void _swapUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      if (_controller.text.isNotEmpty) {
        _convert();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _fromUnit = _units[_selectedCategory]![0];
                  _toUnit = _defaultToUnits[_fromUnit]!;
                  if (_controller.text.isNotEmpty) {
                    _convert();
                  }
                });
              },
              items: _units.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (String? newValue) {
                    _updateUnits(newValue!, true);
                  },
                  items: _units[_selectedCategory]!.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapUnits,
                ),
                DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (String? newValue) {
                    _updateUnits(newValue!, false);
                  },
                  items: _units[_selectedCategory]!.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value',
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  _convert();
                }
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Result: $_result'),
            ),
          ],
        ),
      ),
    );
  }
}

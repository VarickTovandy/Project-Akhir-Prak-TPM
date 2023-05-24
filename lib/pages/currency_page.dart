import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  double _rupiah = 0;
  double _dollar = 0;
  double _yen = 0;
  double _euro = 0;
  double _yuan = 0;
  double _peso = 0;

  void _convertCurrency() {
    setState(() {
      _dollar = _rupiah / 15000; // 1 Dollar = 15,000 Rupiah
      _yen = _rupiah / 140; // 1 Yen = 140 Rupiah
      _euro = _rupiah / 17000; // 1 Euro = 17,000 Rupiah
      _yuan = _rupiah / 2200; // 1 Yuan = 2,200 Rupiah
      _peso = _rupiah / 300; // 1 Peso = 300 Rupiah
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Converter',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.blue.withOpacity(0.3),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount in Rupiah',
              ),
              onChanged: (value) {
                setState(() {
                  _rupiah = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 24),
            Text(
              'Dollar: \$$_dollar',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Yen: ¥$_yen',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Euro: €$_euro',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Yuan: ¥$_yuan',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Peso: ₱$_peso',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

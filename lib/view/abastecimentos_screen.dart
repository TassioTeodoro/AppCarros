import 'package:flutter/material.dart';

class AbastecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Abastecimentos')),
      body: Center(
        child: Text(
          'Aqui você poderá visualizar e registrar seus abastecimentos.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

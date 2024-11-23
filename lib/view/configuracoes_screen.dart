import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Center(
        child: Text(
          'Aqui você poderá alterar as configurações do aplicativo.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

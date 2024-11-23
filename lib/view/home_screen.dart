import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controle de Abastecimento')),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Bem-vindo ao Controle de Abastecimento!'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'vehicle_list_screen.dart'; // Tela de Meus Veículos
import 'refueling_history_screen.dart'; // Tela de Histórico de Abastecimentos

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Abastecimento'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(), // Adicionado Menu Drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bem-vindo ao Controle de Abastecimento!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Gerencie seus veículos e acompanhe o histórico de abastecimentos de forma simples e eficiente.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Redirecionar para a tela de Meus Veículos
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VehicleListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Acessar Meus Veículos',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Redirecionar para a tela de Histórico de Abastecimentos
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RefuelingHistoryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Ver Histórico de Abastecimentos',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

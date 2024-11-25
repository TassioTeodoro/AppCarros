import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/view/home_screen.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:flutter_application_1/view/vehicle_list_screen.dart';
import 'package:flutter_application_1/view/vehicle_form_screen.dart';

class CustomDrawer extends StatelessWidget {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          FutureBuilder<Map<String, String>>(
            future: _authController.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(child: CircularProgressIndicator(color: Colors.white)),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Text(
                      'Erro ao carregar dados',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              }

              final userData = snapshot.data!;
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                  userData['name'] ?? 'Usuário',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  userData['email'] ?? 'Email não disponível',
                  style: TextStyle(fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    userData['name']?.substring(0, 1).toUpperCase() ?? 'U',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: Colors.blue),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.car_rental, color: Colors.blue),
                  title: Text('Meus Veículos'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VehicleListScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add, color: Colors.green),
                  title: Text('Adicionar Veículo'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VehicleFormScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history, color: Colors.orange),
                  title: Text('Histórico de Abastecimentos'),
                  onTap: () {
                    Navigator.pushNamed(context, '/historico-abastecimentos');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.purple),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.pushNamed(context, '/perfil');
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout'),
                  onTap: () async {
                    await _authController.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

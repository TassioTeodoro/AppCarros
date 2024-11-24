import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import '../controllers/auth_controller.dart';

class CustomDrawer extends StatelessWidget {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu de Navegação',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text('Meus Veículos'),
            onTap: () {
              Navigator.pushNamed(context, '/meus-veiculos');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar Veículo'),
            onTap: () {
              Navigator.pushNamed(context, '/adicionar-veiculo');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Histórico de Abastecimentos'),
            onTap: () {
              Navigator.pushNamed(context, '/historico-abastecimentos');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
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
    );
  }
}

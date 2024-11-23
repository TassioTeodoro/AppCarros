import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_screen.dart';
import 'package:flutter_application_1/view/register_screen.dart';
import 'package:flutter_application_1/view/reset_password.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela principal (Home)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Entrar'),
            ),
            TextButton(
              onPressed: () {
                // Navegar para a tela de Registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Criar Conta'),
            ),
            TextButton(
              onPressed: () {
                // Navegar para a tela de Recuperação de Senha
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                );
              },
              child: Text('Esqueceu a Senha?'),
            ),
          ],
        ),
      ),
    );
  }
}

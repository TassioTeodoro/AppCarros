import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Senha')),
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
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Voltar para a tela de Login após o envio do e-mail
                Navigator.pop(context);
              },
              child: Text('Enviar e-mail de recuperação'),
            ),
          ],
        ),
      ),
    );
  }
}

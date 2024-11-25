import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/view/home_screen.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:flutter_application_1/view/vehicle_list_screen.dart';
import 'package:flutter_application_1/view/vehicle_form_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void  main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Abastecimento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Tela inicial
      routes: {
        '/': (context) => HomeScreen(), // Rota da tela inicial
        '/meus-veiculos': (context) => VehicleListScreen(), // Rota para "Meus Veículos"
        '/adicionar-veiculo': (context) => VehicleFormScreen(), // Rota para adicionar veículo
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/view/home_screen.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:flutter_application_1/view/refuel_history_screen.dart';
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
  debugShowCheckedModeBanner: false,
  title: 'Controle de Abastecimento',
  theme: ThemeData(primarySwatch: Colors.blue),
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/meus-veiculos':
        return MaterialPageRoute(builder: (context) => VehicleListScreen());
      case '/adicionar-veiculo':
        return MaterialPageRoute(builder: (context) => VehicleFormScreen());
      case '/historico-abastecimentos':
        if (settings.arguments is String) {
          final vehicleId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => RefuelingHistoryScreen(vehicleId: vehicleId),
          );
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Erro: Vehicle ID não fornecido.')),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Página não encontrada.')),
          ),
        );
    }
  },
  home: HomeScreen(),
);

  }
}


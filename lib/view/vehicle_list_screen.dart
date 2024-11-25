import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/vehicle_controller.dart';
import 'package:flutter_application_1/model/vehicle_model.dart';
import 'package:flutter_application_1/view/vehicle_form_screen.dart';
import 'package:flutter_application_1/widgets/custom_drawer.dart';


class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleController _vehicleController = VehicleController();
  late Future<List<VehicleModel>> _vehiclesFuture;

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _vehicleController.fetchVehicles();
  }

  Future<void> _refreshVehicles() async {
    setState(() {
      _vehiclesFuture = _vehicleController.fetchVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Veículos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VehicleFormScreen()),
              ).then((_) => _refreshVehicles());
            },
          ),
        ],
      ),
      drawer: CustomDrawer(), // Adicionando o Menu Drawer
      body: FutureBuilder<List<VehicleModel>>(
        future: _vehiclesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os veículos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado.'));
          }

          final vehicles = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshVehicles,
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return ListTile(
                  title: Text('${vehicle.name} (${vehicle.model})'),
                  subtitle: Text('Ano: ${vehicle.year} - Placa: ${vehicle.plate}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implementar edição no próximo passo
                    },
                  ),
                  onLongPress: () {
                    _confirmDeletion(vehicle.id!);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _confirmDeletion(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir Veículo'),
        content: Text('Deseja realmente excluir este veículo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _vehicleController.deleteVehicle(id);
              Navigator.pop(context);
              _refreshVehicles();
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

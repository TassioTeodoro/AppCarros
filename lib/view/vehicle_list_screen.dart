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
      drawer: CustomDrawer(),
      body: FutureBuilder<List<VehicleModel>>(
        future: _vehiclesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro ao carregar os veículos.'),
                  TextButton(
                    onPressed: _refreshVehicles,
                    child: Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Você ainda não cadastrou veículos.'),
            );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleFormScreen(vehicle: vehicle),
                        ),
                      ).then((_) => _refreshVehicles());
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
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir este veículo? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteVehicleWithLoading(id);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteVehicleWithLoading(String id) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
    try {
      await _vehicleController.deleteVehicle(id);
      _refreshVehicles();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir o veículo.')),
      );
    } finally {
      Navigator.pop(context); // Fecha o diálogo de carregamento
    }
  }
}

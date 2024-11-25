import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/controllers/refuel_service.dart';
import 'package:flutter_application_1/model/refuel.dart';


class RefuelingHistoryScreen extends StatefulWidget {
  final String vehicleId;

  const RefuelingHistoryScreen({required this.vehicleId});

  @override
  _RefuelingHistoryScreenState createState() => _RefuelingHistoryScreenState();
}

class _RefuelingHistoryScreenState extends State<RefuelingHistoryScreen> {
  late Future<List<Refuel>> _refuelingHistory;
  final RefuelService _refuelService = RefuelService();

  @override
  void initState() {
    super.initState();
    _refuelingHistory = _fetchRefuelingHistory();
  }

  Future<List<Refuel>> _fetchRefuelingHistory() {
    return _refuelService.getRefuelsByVehicle(widget.vehicleId);
  }

  Future<void> _refreshHistory() async {
    setState(() {
      _refuelingHistory = _fetchRefuelingHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Refuel>>(
        future: _refuelingHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum abastecimento registrado.'));
          }

          final history = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshHistory,
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final refuel = history[index];
                return ListTile(
                  leading: Icon(Icons.local_gas_station, color: Colors.blue),
                  title: Text('Data: ${refuel.date.toLocal()}'.split(' ')[0]),
                  subtitle: Text(
                      'Litros: ${refuel.liters} L | Quilometragem: ${refuel.mileage} km'),
                  trailing: Text(
                    'ID: ${refuel.id}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

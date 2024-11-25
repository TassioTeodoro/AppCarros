import 'package:flutter/material.dart';

class RefuelingHistoryScreen extends StatefulWidget {
  @override
  _RefuelingHistoryScreenState createState() => _RefuelingHistoryScreenState();
}

class _RefuelingHistoryScreenState extends State<RefuelingHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _refuelingHistory;

  @override
  void initState() {
    super.initState();
    _refuelingHistory = _fetchRefuelingHistory();
  }

  Future<List<Map<String, dynamic>>> _fetchRefuelingHistory() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      {
        'vehicle': 'Carro 1',
        'date': '24/11/2024',
        'quantity': 45.0,
        'cost': 250.0,
      },
      {
        'vehicle': 'Moto 2',
        'date': '20/11/2024',
        'quantity': 12.5,
        'cost': 90.0,
      },
      {
        'vehicle': 'Caminhão X',
        'date': '10/11/2024',
        'quantity': 100.0,
        'cost': 650.0,
      },
    ];
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
                final item = history[index];
                return ListTile(
                  leading: Icon(Icons.local_gas_station, color: Colors.blue),
                  title: Text('${item['vehicle']}'),
                  subtitle: Text(
                      'Data: ${item['date']} | Quantidade: ${item['quantity']} L'),
                  trailing: Text('R\$ ${item['cost'].toStringAsFixed(2)}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

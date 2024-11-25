import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/refuel_service.dart';
import 'package:flutter_application_1/model/refuel.dart';

class RefuelFormScreen extends StatefulWidget {
  final String vehicleId;

  const RefuelFormScreen({required this.vehicleId});

  @override
  _RefuelFormScreenState createState() => _RefuelFormScreenState();
}

class _RefuelFormScreenState extends State<RefuelFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _litersController = TextEditingController();
  final _mileageController = TextEditingController();
  DateTime? _selectedDate;

  final RefuelService _refuelService = RefuelService();

  void _saveRefuel() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final refuel = Refuel(
        id: '', // ID será gerado automaticamente pelo Firestore
        vehicleId: widget.vehicleId,
        liters: double.parse(_litersController.text),
        mileage: int.parse(_mileageController.text),
        date: _selectedDate!,
      );

      await _refuelService.addRefuel(refuel);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _litersController,
                decoration: InputDecoration(labelText: 'Quantidade de Litros'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade de litros';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mileageController,
                decoration: InputDecoration(labelText: 'Quilometragem Atual'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quilometragem atual';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? 'Selecione a data'
                      : 'Data: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text('Escolher Data'),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _saveRefuel,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

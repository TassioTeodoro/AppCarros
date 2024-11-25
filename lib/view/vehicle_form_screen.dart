import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/vehicle_model.dart';

class VehicleFormScreen extends StatefulWidget {
  final VehicleModel? vehicle; // Veículo opcional para edição

  VehicleFormScreen({this.vehicle});

  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.vehicle != null) {
      _nameController.text = widget.vehicle!.name;
      _modelController.text = widget.vehicle!.model;
      _yearController.text = widget.vehicle!.year.toString();
      _plateController.text = widget.vehicle!.plate;
    }
  }

  Future<void> _saveVehicle() async {
    setState(() => _isLoading = true);

    try {
      if (widget.vehicle == null) {
        await _firestore.collection('vehicles').add({
          'name': _nameController.text.trim(),
          'model': _modelController.text.trim(),
          'year': int.parse(_yearController.text.trim()),
          'plate': _plateController.text.trim(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veículo cadastrado com sucesso!')),
        );
      } else {
        await _firestore.collection('vehicles').doc(widget.vehicle!.id).update({
          'name': _nameController.text.trim(),
          'model': _modelController.text.trim(),
          'year': int.parse(_yearController.text.trim()),
          'plate': _plateController.text.trim(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veículo atualizado com sucesso!')),
        );
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar veículo: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle == null ? 'Cadastrar Veículo' : 'Editar Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _plateController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveVehicle,
                    child: Text(widget.vehicle == null ? 'Salvar' : 'Atualizar'),
                  ),
          ],
        ),
      ),
    );
  }
}

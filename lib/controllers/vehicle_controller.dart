import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/vehicle_model.dart';

class VehicleController {
  final CollectionReference _vehicleCollection =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> addVehicle(VehicleModel vehicle) async {
  try {
    await _vehicleCollection.add(vehicle.toMap());
    print('Veículo adicionado com sucesso.');
  } catch (e) {
    print('Erro ao adicionar veículo: $e');
    rethrow; 
  }
}

  Future<List<VehicleModel>> fetchVehicles() async {
  try {
    final snapshot = await _vehicleCollection.get();
    print('Documentos encontrados: ${snapshot.docs.length}');
    return snapshot.docs
        .map((doc) {
          print('Documento: ${doc.data()}');
          return VehicleModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        })
        .toList();
  } catch (e) {
    print('Erro ao buscar veículos: $e');
    rethrow;
  }
}

Future<void> updateVehicle(VehicleModel vehicle) async {
  if (vehicle.id == null) {
    throw Exception('ID do veículo é necessário para atualização.');
  }
  try {
    await _vehicleCollection.doc(vehicle.id).update(vehicle.toMap());
    print('Veículo atualizado com sucesso.');
  } catch (e) {
    print('Erro ao atualizar veículo: $e');
    rethrow;
  }
}

Future<void> deleteVehicle(String id) async {
  try {
    print('Excluindo veículo com ID: $id');
    await _vehicleCollection.doc(id).delete();
    print('Veículo excluído com sucesso.');
  } catch (e) {
    print('Erro ao excluir veículo: $e');
    rethrow;
  }
}
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/refuel.dart';


class RefuelService {
  final CollectionReference _refuelsCollection =
      FirebaseFirestore.instance.collection('refuels');

  Future<void> addRefuel(Refuel refuel) async {
    await _refuelsCollection.add(refuel.toFirestore());
  }

  Future<List<Refuel>> getRefuelsByVehicle(String vehicleId) async {
    final querySnapshot = await _refuelsCollection
        .where('vehicleId', isEqualTo: vehicleId)
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Refuel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}

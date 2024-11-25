import 'package:cloud_firestore/cloud_firestore.dart';

class Refuel {
  final String id;
  final String vehicleId;
  final double liters;
  final int mileage;
  final DateTime date;

  Refuel({
    required this.id,
    required this.vehicleId,
    required this.liters,
    required this.mileage,
    required this.date,
  });

  factory Refuel.fromFirestore(Map<String, dynamic> data, String id) {
    return Refuel(
      id: id,
      vehicleId: data['vehicleId'],
      liters: data['liters'],
      mileage: data['mileage'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'vehicleId': vehicleId,
      'liters': liters,
      'mileage': mileage,
      'date': date,
    };
  }
}

class VehicleModel {
  final String? id;
  final String name;
  final String model;
  final int year;
  final String plate;

  VehicleModel({
    this.id,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map, String id) {
    return VehicleModel(
      id: id,
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? 0,
      plate: map['plate'] ?? '',
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'year': year,
      'plate': plate,
    };
  }
}

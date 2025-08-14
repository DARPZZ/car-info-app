// car_info.dart
class CarInfo {
  final String regNr;
  final String status;
  final bool rentedCar;
  final String leasingPeriode;
  final String carNameType;
  final String carModelType;
  final int modelAar;
  final double motorStoerrelse; 
  final double motorHestekraefter; 
  final double motorKmPerLiter;

  CarInfo({
    required this.regNr,
    required this.status,
    required this.rentedCar,
    required this.leasingPeriode,
    required this.carNameType,
    required this.carModelType,
    required this.modelAar,
    required this.motorStoerrelse,
    required this.motorHestekraefter,
    required this.motorKmPerLiter,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json) {
    return CarInfo(
      regNr: json['regNr'] ?? '',
      status: json['status'] ?? '',
      rentedCar: json['rentedcar'] ?? false,
      leasingPeriode: json['leasingPeriode'] ?? '',
      carNameType: json['car_name_type'] ?? '',
      carModelType: json['car_model_type'] ?? '',
      modelAar: json['modelår'] ?? 0,
      motorStoerrelse: (json['motor_størrelse'] ?? 0),
      motorHestekraefter: (json['motor_hestekræfter'] ?? 0),
      motorKmPerLiter: (json['motorKmPerLiter'] ?? 0),
    );
  }
}

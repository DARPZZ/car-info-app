// ignore: file_names
import 'package:flutter/material.dart';

import 'car_info.dart';

class CarInfoProvider extends ChangeNotifier {
  CarInfo? _carInfo;

  CarInfo? get carInfo => _carInfo;

  void setCarInfo(CarInfo info) {
    _carInfo = info;
    notifyListeners();
  }
}


import 'package:car_app_2/CarInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
   
    final carInfo = Provider.of<CarInfoProvider>(context).carInfo;

    if (carInfo == null) {
      return const Scaffold(
        body: Center(child: Text('No car info available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Info'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.ad_units_outlined), label: "Test")
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("RegNr: ${carInfo.regNr}", style: const TextStyle(fontSize: 18)),
            Text("Status: ${carInfo.status}", style: const TextStyle(fontSize: 18)),
            Text("Rented Car: ${carInfo.rentedCar ? 'Yes' : 'No'}", style: const TextStyle(fontSize: 18)),
            Text("Leasing Period: ${carInfo.leasingPeriode}", style: const TextStyle(fontSize: 18)),
            Text("Car Name: ${carInfo.carNameType}", style: const TextStyle(fontSize: 18)),
            Text("Car Model: ${carInfo.carModelType}", style: const TextStyle(fontSize: 18)),
            Text("Model Year: ${carInfo.modelAar}", style: const TextStyle(fontSize: 18)),
            Text("Engine Size: ${carInfo.motorStoerrelse} L", style: const TextStyle(fontSize: 18)),
            Text("Horse Power: ${carInfo.motorHestekraefter} HP", style: const TextStyle(fontSize: 18)),
            Text("Km per Liter: ${carInfo.motorKmPerLiter}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

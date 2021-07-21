import 'package:flutter/material.dart';
import '../models/medicine.dart';

class Medicines with ChangeNotifier {
  List<Medicine> _meds = [
    Medicine(
      id: 'm1',
      imageUrl: 'assets/images/injection.png',
      reason: 'For Lower back pain',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      title: 'Cetamol',
    ),
  ];

  List<Medicine> get meds {
    return [..._meds];
  }

  addMedicine(Medicine medicine) {
    final newMedicine = new Medicine(
      id: medicine.id,
      imageUrl: medicine.imageUrl,
      reason: medicine.reason,
      date: medicine.date,
      title: medicine.title,
      time: medicine.time,
    );
    _meds.add(newMedicine);
    print('Hey ${newMedicine.title}');
    notifyListeners();
  }

  int itemCount() {
    return _meds.length;
  }
}

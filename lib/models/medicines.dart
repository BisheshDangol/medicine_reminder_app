import 'package:flutter/material.dart';
import '../models/medicine.dart';

class Medicines with ChangeNotifier {
  List<Medicine> _meds = [];

  List<Medicine> get meds {
    return [..._meds];
  }

  removeMedicine(int index) {
    _meds.removeAt(index);
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async {
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

  findById(int index) {
    return _meds.contains(index);
  }
}

import 'package:flutter/material.dart';
import '../models/medicine.dart';

class Medicines with ChangeNotifier {
  List<Medicine> _meds = [
    Medicine(
      id: 'm1',
      imageUrl: 'assets/images/injection.png',
      reason: 'For Lower back pain',
      time: DateTime.now(),
      title: 'Cetamol',
    ),
    Medicine(
      id: 'm2',
      imageUrl: 'assets/images/injection.png',
      reason: 'For Lower back pain',
      time: DateTime.now(),
      title: 'Paracetamol',
    ),
    Medicine(
      id: 'm3',
      imageUrl: 'assets/images/injection.png',
      reason: 'For Lower back pain',
      time: DateTime.now(),
      title: 'Aspirin',
    ),
    Medicine(
      id: 'm4',
      imageUrl: 'assets/images/injection.png',
      reason: 'For Lower back pain',
      time: DateTime.now(),
      title: 'Flexon',
    ),
  ];

  List<Medicine> get meds {
    return [..._meds];
  }

  int itemCount() {
    return _meds.length;
  }
}

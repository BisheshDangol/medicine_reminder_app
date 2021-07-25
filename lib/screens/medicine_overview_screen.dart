import 'package:flutter/material.dart';

import 'package:medicine_reminder_app/widgets/medicine_item.dart';
import '../models/medicines.dart';
import 'package:provider/provider.dart';

class MedicineOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var medicines = Provider.of<Medicines>(context);
    return Column(
      children: [
        Expanded(
          child: medicines.meds.isEmpty
              ? Center(
                  child: Text(
                      'Press the "+" button to add your medicine to the list'),
                )
              : MedicineItem(medicines: medicines),
        ),
      ],
    );
  }
}

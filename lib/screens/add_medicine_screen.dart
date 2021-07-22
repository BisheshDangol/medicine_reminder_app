import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicine.dart';
import 'package:provider/provider.dart';
import '../models/medicines.dart';

class AddMedicineScreen extends StatefulWidget {
  static const routeName = '/add-medicine';

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _titleController = TextEditingController();
  final _reasonController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String chosenValue = 'injection';

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    super.initState();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  String img(String imageUrl) {
    if (imageUrl == 'injection') {
      return 'assets/images/injection.png';
    } else if (imageUrl == 'capsule') {
      return 'assets/images/capsule.jpg';
    } else if (imageUrl == 'liquid') {
      return 'assets/images/liquid.png';
    }
    return 'assets/images/capsule.jpg';
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _selectedTime,
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  void addMedicineBtn(Medicines med) {
    var _editedMedicine = new Medicine(
      id: DateTime.now().toString(),
      imageUrl: img(chosenValue),
      reason: _reasonController.text,
      date: _selectedDate,
      title: _titleController.text,
      time: _selectedTime,
    );
    med.addMedicine(_editedMedicine);
    Navigator.of(context).pop();
  }

  List type = [
    "injection",
    "capsule",
    "liquid",
  ];

  @override
  Widget build(BuildContext context) {
    final medicines = Provider.of<Medicines>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Medicine Name'),
              controller: _titleController,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Reason'),
              controller: _reasonController,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Medicine Type: '),
                DropdownButton(
                  items: type.map((dropDownItem) {
                    return DropdownMenuItem(
                      child: Text(dropDownItem),
                      value: dropDownItem,
                    );
                  }).toList(),
                  value: chosenValue,
                  onChanged: (newValue) {
                    setState(() {
                      chosenValue = newValue.toString();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Picked Date: ${DateFormat.yMMMMd().format(_selectedDate)}',
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _presentDatePicker();
                      }),
                ],
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Picked Time: ${_selectedTime.hour} : ${_selectedTime.minute}',
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _presentTimePicker();
                      }),
                ],
              ),
            ),
            SizedBox(height: 190),
            ElevatedButton(
              onPressed: () {
                addMedicineBtn(medicines);
              },
              child:
                  Text('Add Medicine', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}

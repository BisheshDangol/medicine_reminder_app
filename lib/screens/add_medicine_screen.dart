import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app/main.dart';
import '../models/medicine.dart';
import 'package:provider/provider.dart';
import '../models/medicines.dart';
import 'package:timezone/timezone.dart' as tz;

class AddMedicineScreen extends StatefulWidget {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  const AddMedicineScreen(
    this.notificationAppLaunchDetails, {
    Key? key,
  }) : super(key: key);
  static const routeName = '/add-medicine';

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

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

  var random = Random();

  int randomNumber() {
    int generatedValue = 0;
    var n1 = random.nextInt(16);
    var n2 = random.nextInt(15);
    if (n1 != n2) {
      generatedValue = n1;
    }
    return generatedValue;
  }

  void addMedicineBtn(Medicines med) {
    var _editedMedicine = new Medicine(
      id: randomNumber().toString(),
      // id: DateTime.now().millisecond.toInt().toString(),
      imageUrl: img(chosenValue),
      reason: _reasonController.text,
      date: _selectedDate,
      title: _titleController.text,
      time: _selectedTime,
    );
    med.addMedicine(_editedMedicine);
    print(randomNumber().toString());
    Navigator.of(context).pop();
  }

  List type = [
    "injection",
    "capsule",
    "liquid",
  ];

  Future<void> _scheduleDailyTenAMNotification(List<Medicine> med) async {
    // ignore: await_only_futures
    await med
        .map(
          (medicine) => flutterLocalNotificationsPlugin.zonedSchedule(
              int.parse(medicine.id),
              medicine.title,
              'It is time for your medication for ${medicine.reason}',
              _nextInstanceOfTenAM(medicine.time.hour.toString(),
                  medicine.time.minute.toString()),
              const NotificationDetails(
                android: AndroidNotificationDetails(
                    'daily notification channel id',
                    'daily notification channel name',
                    'daily notification description'),
              ),
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: DateTimeComponents.time),
        )
        .toList();
  }

  tz.TZDateTime _nextInstanceOfTenAM(String hours, String minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      int.parse(hours),
      int.parse(
        minutes,
      ),
    );
    return scheduledDate = scheduledDate.add(const Duration(seconds: 0));
  }

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
              onPressed: () async {
                addMedicineBtn(medicines);
                await _scheduleDailyTenAMNotification(medicines.meds);
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

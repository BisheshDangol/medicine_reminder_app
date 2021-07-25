import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/medicines.dart';

class MedicineItem extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final Medicines medicines;
  MedicineItem({required this.medicines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: UniqueKey(),
          onDismissed: (direction) {
            flutterLocalNotificationsPlugin
                .cancel(int.parse(medicines.meds[index].id));
            medicines.removeMedicine(index);
          },
          background: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.red[300],
            ),
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.delete,
            ),
            alignment: Alignment.centerRight,
          ),
          child: Container(
            height: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.white54),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(medicines.meds[index].imageUrl),
                  height: 100,
                  width: 100,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 200,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Name: ${medicines.meds[index].title}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Reason: ${medicines.meds[index].reason}',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(
                          medicines.meds[index].date,
                        )} | Time: ${medicines.meds[index].time.hour}: ${medicines.meds[index].time.minute}',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: medicines.itemCount(),
    );
  }
}

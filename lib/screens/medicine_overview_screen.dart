import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/medicines.dart';
import 'package:provider/provider.dart';

class MedicineOverViewScreen extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        medicines.removeMedicine(index);
                        flutterLocalNotificationsPlugin.cancel(index);
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
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child:
                                  Image.asset(medicines.meds[index].imageUrl),
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
                                    'Reminder: ${medicines.meds[index].date}',
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
                ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/screens/add_medicine_screen.dart';
import '../screens/medicine_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remind Me',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green[400]),
            margin: EdgeInsets.all(10),
            width: mediaQuery.size.width * 1,
            height: mediaQuery.size.height * 0.2,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text('Hello there!',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white)),
                ),
                FittedBox(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text('Let us help you with those medicines',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Medicine List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.green[100],
            ),
            height: mediaQuery.size.height * 0.5,
            child: MedicineOverViewScreen(),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddMedicineScreen.routeName);
            },
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

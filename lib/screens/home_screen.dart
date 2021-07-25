import 'package:flutter/material.dart';
import '../widgets/medicine_info.dart';
import '../screens/add_medicine_screen.dart';
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
          MedicineInfo(),
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

import 'package:flutter/material.dart';
import '../screens/add_medicine_screen.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import '../models/medicines.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Medicines(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminder App',
        home: HomeScreen(),
        theme: ThemeData(
          fontFamily: 'EncodeSansSc',
          textTheme: TextTheme(
              headline1: TextStyle(fontFamily: 'VarelaRound', fontSize: 50),
              headline5: TextStyle(fontFamily: 'VarelaRound', fontSize: 20)),
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        routes: {
          AddMedicineScreen.routeName: (ctx) => AddMedicineScreen(),
        },
      ),
    );
  }
}

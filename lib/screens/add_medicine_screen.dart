import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  static const routeName = '/add-medicine';

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

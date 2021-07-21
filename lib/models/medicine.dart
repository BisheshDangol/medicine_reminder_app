import 'package:flutter/material.dart';

class Medicine with ChangeNotifier {
  String id;
  String title;
  String reason;
  String imageUrl;
  DateTime date;
  TimeOfDay time;

  Medicine({
    required this.id,
    required this.imageUrl,
    required this.reason,
    required this.date,
    required this.title,
    required this.time,
  });
}

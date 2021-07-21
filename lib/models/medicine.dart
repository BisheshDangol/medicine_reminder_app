import 'package:flutter/material.dart';

class Medicine with ChangeNotifier {
  String id;
  String title;
  String reason;
  String imageUrl;
  DateTime time;

  Medicine({
    required this.id,
    required this.imageUrl,
    required this.reason,
    required this.time,
    required this.title,
  });
}

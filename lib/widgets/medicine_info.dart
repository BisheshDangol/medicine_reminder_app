import 'package:flutter/material.dart';

class MedicineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.green[400]),
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
    );
  }
}

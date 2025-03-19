import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.setLocale(Locale('en'));
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                context.setLocale(Locale('ar'));
              },
              child: Text('العربية'),
            ),
            Row(
              children: [
                Text(
                  "The language has been changed to English.".tr(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}

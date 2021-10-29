import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OfflineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Lottie.asset(
            'assets/no_internet_connection.json',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

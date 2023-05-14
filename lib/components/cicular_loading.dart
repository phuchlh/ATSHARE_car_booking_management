import 'package:booking_car/constants.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 100,
        padding: EdgeInsets.all(8),
        child: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
            // color: loading,
          ),
        ),
      );
}

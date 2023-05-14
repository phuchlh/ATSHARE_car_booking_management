import 'package:booking_car/Screens/profile/components/box_profile.dart';
import 'package:flutter/material.dart';

class ListViewProfile extends StatelessWidget {
  final List _profile = ['profile 1','profile 2','profile 3','profile 4', 'profile 5', 'profile 6',];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _profile.length,
      itemBuilder: (BuildContext context, int index) {
        return BoxProfile(child: _profile[index],);
      },
    );
  }
}

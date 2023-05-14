import 'package:booking_car/screens/car_detail/components/car_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CarInformation extends StatelessWidget {
  const CarInformation({
    required this.mapItem,
    super.key,
    required this.title,
    required this.icon,
    this.content,
    this.pdLeft,
    this.pdBot,
  });

  final String title;
  final IconData icon;
  final String? content;
  final double? pdLeft;
  final double? pdBot;
  final Map<String, String> mapItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(icon),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [_buildCarCondition()],
      ),
    );
  }

  Widget _buildCarCondition() {
    List<CarCondition> carConditions = mapItem.entries
        .map((entry) => CarCondition(
              title: entry.key,
              content: entry.value,
              pdLeft: 20,
              pdBot: 10,
              pdRight: 20,
            ))
        .toList();
    return Column(
      children: carConditions,
    );
  }
}
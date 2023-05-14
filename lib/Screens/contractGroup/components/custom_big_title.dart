import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomDescription extends StatelessWidget {
  final String title;
  final String? description;
  const CustomDescription({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
          child: Text(
            description == null ? '' : description!,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(230, 128, 124, 124)),
          ),
        ),
      ],
    );
  }
}

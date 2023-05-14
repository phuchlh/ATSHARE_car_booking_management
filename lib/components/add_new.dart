import 'package:flutter/material.dart';

class AddNew extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onClicked;
  final double heightBox, widthBox;
  const AddNew(
      {super.key,
      required this.title,
      required this.icon,
      required this.onClicked,
      required this.heightBox,
      required this.widthBox});

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: heightBox,
    //   width: MediaQuery.of(context).size.width * widthBox,
    //   child: ListTile(
    //     shape: RoundedRectangleBorder(
    //       side: BorderSide(color: Colors.black, width: 1),
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //     minLeadingWidth: 1,
    //     leading: Icon(icon),
    //     visualDensity: VisualDensity(vertical: -4),
    //     onTap: (() => {onClicked}),
    //     title: Text(
    //       title,
    //       style: TextStyle(fontSize: 14),
    //     ),
    //   ),
    // );

    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: onClicked,
          icon: Icon(icon, color: Colors.black54),
          label: Text(
            title,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

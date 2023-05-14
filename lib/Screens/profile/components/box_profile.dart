import 'package:flutter/material.dart';

class BoxProfile extends StatelessWidget {
  final String child;
  const BoxProfile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
      child: Container(

        height: 140,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius:  BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                ),
                Container(
                  width: 200,
                  height: 120,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

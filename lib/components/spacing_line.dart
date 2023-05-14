import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Spacing extends StatelessWidget {
  const Spacing(
      {super.key,
      required this.icon,
      required this.text,
      this.pdtop,
      this.pdbottom,
      this.pdleft,
      this.pdright,
      required this.sizeIcon,
      required this.isCarDetailPage,
      required this.title});

  final IconData icon;
  final String text;
  final double? pdtop;
  final double? pdbottom;
  final double? pdleft;
  final double? pdright;
  final double sizeIcon;
  final bool isCarDetailPage;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (isCarDetailPage) {
      return Flexible(
        flex: 1,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: pdleft ?? 0,
                right: pdright ?? 0,
                top: pdtop ?? 0,
                bottom: pdbottom ?? 0,
              ),
            ),
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(
                left: pdleft ?? 0,
                right: pdright ?? 0,
                top: pdtop ?? 0,
                bottom: pdbottom ?? 0,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    } else {
      return Flexible(
        flex: 1,
        child: Row(
          children: [
            Icon(
              icon,
              size: sizeIcon,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: pdleft ?? 0,
                right: pdright ?? 0,
                top: pdtop ?? 0,
                bottom: pdbottom ?? 0,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
  }
}

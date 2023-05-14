import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  final String title;
  final String content;
  final String? description;
  final String? errText;
  final bool? isEnable;
  final double? height;
  final Color? backgroundColor;

  const CustomListTitle({
    super.key,
    required this.title,
    this.height,
    this.isEnable = true,
    required this.content,
    this.backgroundColor,
    this.errText,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 400,
              height: height ?? 35,
              child: TextField(
                maxLines: height == null ? 1 : 5,
                controller: myController,
                enabled: isEnable,
                decoration: InputDecoration(
                  errorText: errText ?? null,
                  fillColor: backgroundColor ?? Colors.grey[200],
                  contentPadding: EdgeInsets.only(left: 10, top: 5, right: 10),
                  hintText: myController.text = content,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.75, color: Colors.black45),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.75, color: Color.fromARGB(255, 235, 105, 96)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.75, color: Colors.black45),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

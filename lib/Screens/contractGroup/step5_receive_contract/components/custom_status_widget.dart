import 'package:flutter/material.dart';

class CustomStatusChange extends StatefulWidget {
  const CustomStatusChange({
    super.key,
  });

  @override
  State<CustomStatusChange> createState() => _CustomStatusChangeState();
}

class _CustomStatusChangeState extends State<CustomStatusChange> {
  bool? selected;
  double opacit = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text('Ban đầu'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Thiệt hại'),
              ),
            ],
            value: selected,
            onChanged: (bool? value) {
              setState(
                () {
                  print(selected.toString());
                  selected = value!;
                  if (value == false) {
                    opacit = 1.0;
                  } else {
                    opacit = 0.0;
                  }
                },
              );
            },
          ),
          AnimatedOpacity(
            opacity: opacit,
            duration: const Duration(milliseconds: 500),
          ),
          AnimatedOpacity(
            opacity: opacit,
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}

Widget _customerText(
    BuildContext context, String title, TextEditingController controller) {
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
            height: 35,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.75, color: Colors.black45)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

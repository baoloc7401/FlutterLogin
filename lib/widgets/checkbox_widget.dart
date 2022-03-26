import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  String title;
  bool? value;
  final ValueChanged<bool?>? onChanged;

  CustomCheckBox(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.value,
              onChanged: widget.onChanged),
          Text(widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue))
        ],
      );
}

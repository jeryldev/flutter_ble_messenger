import 'package:flutter/material.dart';

Widget customElevatedButton(
    {BuildContext context,
    String label,
    void Function() callback,
    double fontSize}) {
  return SizedBox(
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (_) => Theme.of(context).buttonColor,
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(color: Colors.black54),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize, color: Colors.black54),
        ),
      ),
      onPressed: callback,
    ),
  );
}

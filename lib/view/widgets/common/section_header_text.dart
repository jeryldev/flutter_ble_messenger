import 'package:flutter/material.dart';

class SectionHeaderText extends StatelessWidget {
  final String headerText;
  const SectionHeaderText({Key key, this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Text(
          headerText,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;

  const CustomErrorWidget(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.titleTextStyle,
      @required this.descriptionTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(this.title, style: this.titleTextStyle),
        Text(this.description, style: this.descriptionTextStyle),
      ],
    );
  }
}

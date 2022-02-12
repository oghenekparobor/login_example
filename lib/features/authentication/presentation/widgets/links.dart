import 'package:flutter/material.dart';

class Links extends StatelessWidget {
  const Links({
    Key? key,
    required this.label,
    required this.linkIcons,
    required this.color,
  }) : super(key: key);

  final String label;
  final String linkIcons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            linkIcons,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          label,
          softWrap: true,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

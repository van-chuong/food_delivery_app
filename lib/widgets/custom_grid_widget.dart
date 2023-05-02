import 'package:flutter/material.dart';


class CustomGridView extends StatelessWidget {
  final int count;
  final Color color;
  const CustomGridView({
    super.key,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
        ),
      ]
    );
  }
}
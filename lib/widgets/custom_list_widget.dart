import 'package:flutter/material.dart';


class CustomListView extends StatelessWidget {
  final int count;
  final Color color;
  const CustomListView({
    super.key,
    required this.count,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          height: 50,
          color: color,
        );
      },
      itemCount: count,
    );
  }
}
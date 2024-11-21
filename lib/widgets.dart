import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  Color backgroundColor = Colors.blue, // Cor padrão
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    actions: actions,
    title: Align(
      alignment: Alignment.center,  // Alinha o título no centro
      child: Text(title),
    ),
  );
}


class GradientBackground extends StatelessWidget {
  final Widget child;

  GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey, Colors.white],
        ),
      ),
      child: child,
    );
  }
}

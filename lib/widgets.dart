import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  Color backgroundColor = Colors.white,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    actions: actions,
    title: Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
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
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFFFFF9C4), // Amarelo claro
            Color(0xFFFFEB3B), // Amarelo mais forte
          ],
        ),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

AppBar customAppBar({
  required String title,
  Color backgroundColor = Colors.white,
  List<Widget>? actions,
  Widget? customBackButton, // Para substituir o botão de voltar por outro widget, se necessário
  bool automaticallyImplyLeading = true, // Controle explícito do botão de voltar
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    actions: actions,
    automaticallyImplyLeading: false, // Desativa o botão padrão de voltar
    leading: automaticallyImplyLeading
        ? customBackButton ?? BackButton() // Usa o botão personalizado ou o padrão
        : null, // Remove o botão de voltar
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
            Color(0xB6E3D469), // Amarelo claro
            Color(0xDBFFEB3B), // Amarelo mais forte
          ],
        ),
      ),
      child: child,
    );
  }
}

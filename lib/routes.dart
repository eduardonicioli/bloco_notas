import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_note_page.dart';
import 'pages/edit_note_page.dart';

class Routes {
  static const String home = '/';
  static const String addNote = '/add-note';
  static const String editNote = '/edit-note';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case addNote:
        return MaterialPageRoute(builder: (_) => AddNotePage());
      case editNote:
        final note = settings.arguments as Note;
        return MaterialPageRoute(builder: (_) => EditNotePage(note: note));
      default:
        return null;
    }
  }
}

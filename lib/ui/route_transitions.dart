import 'package:material_ui/material_ui.dart';

/// Default Material route using the platform's predictive-back transition.
Route<T> threadPageRoute<T>(Widget page) {
  return MaterialPageRoute<T>(builder: (context) => page);
}

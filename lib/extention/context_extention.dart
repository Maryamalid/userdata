import 'package:flutter/material.dart';

// getTextTheme(BuildContext context) {
//   return Theme.of(context).textTheme;
// }

extension TextStyleExtion on BuildContext {
  TextStyle? displayLarge() => Theme.of(this).textTheme.displayLarge;

  showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<T?> go<T>(Widget widget) async {
    return await Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) {
      return widget;
    }));
  }
}

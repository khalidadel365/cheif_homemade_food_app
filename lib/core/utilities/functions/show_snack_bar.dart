import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required Color color,
  bool showFromTop = true,
}) {
  if (showFromTop) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
        backgroundColor: color,
        icon: Icon(null),
      ),
      displayDuration: const Duration(seconds: 5),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

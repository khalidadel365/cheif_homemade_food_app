import 'package:flutter/material.dart';

import '../styles.dart';

Widget BuildFieldTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.normal),
      ),
    ),
  );
}

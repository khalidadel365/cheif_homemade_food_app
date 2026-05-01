import 'package:flutter/material.dart';

import '../../../../../core/utilities/styles.dart';

Widget buildInfoTile({
  required IconData icon,
  required Color iconColor,
  required Color iconWidgetColor,
  required String title,
  String? trailing,
  Widget? trailingWidget,
}) {
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconWidgetColor),
    ),
    title: Text(
      title,
      style: Styles.textStyle15
    ),
    trailing:
        trailingWidget ??
        Text(
          trailing ?? '',
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold
          )
        ),
  );
}

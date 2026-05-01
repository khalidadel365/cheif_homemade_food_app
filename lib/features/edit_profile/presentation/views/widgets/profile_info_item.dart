import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import 'build_info_tile.dart';

class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem({
    super.key,
    required this.title,
    required this.trailing,
    required this.icon,
  });

  final String title;
  final String trailing;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: buildInfoTile(
        icon: icon,
        iconColor: kSecondaryColor,
        iconWidgetColor: kPrimaryColor,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

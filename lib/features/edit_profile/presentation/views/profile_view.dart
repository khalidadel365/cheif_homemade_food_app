import 'package:cheif_homemade_food/features/edit_profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../core/utilities/styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.withOpacity(0.3), height: 1.0),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 7),
        centerTitle: true,
        title: Text('My Profile', style: Styles.textStyle23),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ProfileViewBody(),
    );
  }
}

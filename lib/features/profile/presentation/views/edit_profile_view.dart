import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:cheif_homemade_food/features/profile/presentation/views/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../core/utilities/api_constants.dart';
import '../../../../core/utilities/styles.dart';
import '../manager/profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.user});
  final ProfileModel user;
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
        title: Text('Edit Profile', style: Styles.textStyle20),
        leading: IconButton(
          onPressed: () {
            context.read<ProfileCubit>().getChefProfile(
              token: ApiConstants.token!,
              id: ApiConstants.id!,
            );
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: EditProfileViewBody(user: user),
    );
  }
}

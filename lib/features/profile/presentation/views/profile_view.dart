import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/core/utilities/service_locator.dart';
import 'package:cheif_homemade_food/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../core/utilities/styles.dart';
import '../../data/repos/profile_repo_imp.dart';
import '../manager/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
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
      body: BlocProvider(
        create:
            (context) => ProfileCubit(
              getIt.get<ProfileRepoImp>(),
            )..getChefProfile(token: ApiConstants.token!, id: ApiConstants.id!),
        child: ProfileViewBody(),
      ),
    );
  }
}

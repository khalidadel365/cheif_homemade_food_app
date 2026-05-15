import 'package:cheif_homemade_food/core/utilities/functions/show_snack_bar.dart';
import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:cheif_homemade_food/features/profile/presentation/views/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../../../core/utilities/app_router.dart';
import '../../../../../core/utilities/styles.dart';
import '../../manager/profile_cubit.dart';
import '../../manager/profile_states.dart';
import 'custom_profile_image.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    context.read<ProfileCubit>().getChefProfile(
      token: ApiConstants.token!,
      id: ApiConstants.id!,
    );
    context.read<ProfileCubit>().toggleChefStatus(token: ApiConstants.token!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          GoRouter.of(context).go(AppRouter.kLoginView);
        } else if (state is LogoutFailureState) {
          showSnackBar(
            context: context,
            message: state.errMessage,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().profileModel;

        if (state is GetProfileFailureState && profile == null) {
          return Center(child: Text(state.errMessage));
        }

        if (profile != null) {
          bool isOnline = profile.isOnline ?? false;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CustomProfileImage(
                        image:
                            profile.userData?.accountInfo?.profilePicUrl ?? "",
                      ),
                      Positioned(
                        bottom: 5,
                        right: 8,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green : Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          "${profile.userData?.accountInfo?.firstName ?? ''} ${profile.userData?.accountInfo?.lastName ?? ''}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (profile.isVerified ?? false) ...[
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profile.userData?.accountInfo?.email ?? "No Email Provided",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      profile.bio ?? "No Bio Available",
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Divider(
                    endIndent: 15,
                    indent: 15,
                    thickness: 0.8,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 120),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Chef Status",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 25,
                          child: Text(
                            isOnline
                                ? "You are currently online to receive orders."
                                : "You are currently offline. Go online to receive orders.",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 30,
                          width: 50,
                          child:
                              state is ToggleChefStatusLoadingState
                                  ? const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                  : Transform.scale(
                                    scale: 0.9,
                                    child: Switch(
                                      value: isOnline,
                                      trackOutlineColor:
                                          WidgetStateProperty.all(
                                            Colors.transparent,
                                          ),
                                      thumbColor: WidgetStateProperty.all(
                                        Colors.white,
                                      ),
                                      activeTrackColor: kPrimaryColor,
                                      inactiveTrackColor: Colors.grey[300],
                                      onChanged: (val) {
                                        context
                                            .read<ProfileCubit>()
                                            .toggleChefStatus(
                                              token: ApiConstants.token!,
                                            );
                                      },
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ProfileInfoItem(
                    icon: Icons.location_on_outlined,
                    title: "Location",
                    trailing: "Egypt",
                  ),
                  const SizedBox(height: 6),
                  ProfileInfoItem(
                    title: 'Customer Rating',
                    trailing: profile.rating?.toString() ?? "0.0",
                    icon: Icons.star_outline,
                  ),
                  const SizedBox(height: 6),
                  ProfileInfoItem(
                    title: "Phone Number",
                    trailing: profile.userData?.accountInfo?.phone ?? "N/A",
                    icon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 6),
                  ProfileInfoItem(
                    title: "Years of Experience",
                    trailing: profile.yearsOfExperience?.toString() ?? "0",
                    icon: Icons.timer_outlined,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        AppRouter.kEditProfileView,
                        extra: {
                          'user': profile,
                          'cubit': BlocProvider.of<ProfileCubit>(context),
                        },
                      );
                    },
                    text: 'Edit Profile',
                    textStyle: Styles.textStyle17.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: kPrimaryColor,
                    borderRadius: 12,
                  ),
                  const SizedBox(height: 12),
                  state is LogoutLoadingState
                      ? const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      )
                      : CustomButton(
                        onPressed: () {
                          if (ApiConstants.token != null) {
                            context.read<ProfileCubit>().logout(
                              token: ApiConstants.token!,
                            );
                          }
                        },
                        text: 'Logout',
                        elevation: 0.5,
                        textStyle: Styles.textStyle17.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: Colors.white,
                        borderRadius: 12,
                      ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: SpinKitPulse(size: 45, color: kPrimaryColor),
        );
      },
    );
  }
}

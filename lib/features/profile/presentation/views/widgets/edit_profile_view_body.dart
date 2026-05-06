import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:cheif_homemade_food/core/utilities/app_router.dart';
import 'package:cheif_homemade_food/core/utilities/functions/show_snack_bar.dart';
import 'package:cheif_homemade_food/features/profile/presentation/manager/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../../../core/utilities/image_helper.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/profile_cubit.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key, required this.user});

  final ProfileModel user;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController experienceController;
  late TextEditingController passwordController;

  String? updatedImageUrl;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    print(widget.user.userData!.accountInfo!.profilePicUrl!);
    firstNameController = TextEditingController(
      text: widget.user.userData!.accountInfo!.firstName,
    );
    lastNameController = TextEditingController(
      text: widget.user.userData!.accountInfo!.lastName,
    );
    emailController = TextEditingController(
      text: widget.user.userData!.accountInfo!.email,
    );
    passwordController = TextEditingController(text: "******");
    bioController = TextEditingController(text: widget.user.bio ?? "");
    locationController = TextEditingController(text: "Egypt");
    phoneController = TextEditingController(
      text: widget.user.userData!.accountInfo!.phone ?? "",
    );
    experienceController = TextEditingController(
      text: widget.user.yearsOfExperience?.toString() ?? "0",
    );

    firstNameController.addListener(_onFieldChanged);
    lastNameController.addListener(_onFieldChanged);
    emailController.addListener(_onFieldChanged);
    bioController.addListener(_onFieldChanged);
    locationController.addListener(_onFieldChanged);
    phoneController.addListener(_onFieldChanged);
    experienceController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    bool hasTextBeenChanged =
        firstNameController.text != widget.user.userData!.accountInfo!.firstName ||
            lastNameController.text != widget.user.userData!.accountInfo!.lastName ||
            emailController.text != widget.user.userData!.accountInfo!.email ||
            bioController.text != (widget.user.bio ?? "") ||
            phoneController.text != (widget.user.userData!.accountInfo!.phone ?? "") ||
            experienceController.text != (widget.user.yearsOfExperience?.toString() ?? "0");

    setState(() {
      isChanged = hasTextBeenChanged;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    locationController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          setState(() {
            isChanged = false;
            updatedImageUrl = state.profileModel.userData?.accountInfo?.profilePicUrl;
          });
          showSnackBar(
            context: context,
            message: 'Profile updated successfully',
            color: Colors.green,
          );
        } else if (state is UpdateProfileImageSuccess) {
          setState(() {
            updatedImageUrl = state.accountInfo.profilePicUrl;
          });
          showSnackBar(
            context: context,
            message: 'Profile picture updated successfully',
            color: Colors.green,
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(
                      updatedImageUrl ?? widget.user.userData?.accountInfo?.profilePicUrl ?? "",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ImageHelper.pickImageWithChoice(context).then((value) {
                        if (value != null) {
                          context.read<ProfileCubit>().updateProfileImage(
                            imageProfile: value,
                            token: ApiConstants.token!,
                          );
                        }
                      });
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: kPrimaryColor,
                      child: Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel("First Name"),
                      CustomTextFormField(
                        controller: firstNameController,
                        hintText: "First name",
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel("Last Name"),
                      CustomTextFormField(
                        controller: lastNameController,
                        hintText: "Last name",
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Email Address"),
            CustomTextFormField(
              controller: emailController,
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Kitchen Story (Bio)"),
            CustomTextFormField(
              controller: bioController,
              hintText: "Tell your story",
              maxLines: 3,
              prefixIcon: const Icon(Icons.menu_book_outlined),
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Location"),
            CustomTextFormField(
              controller: locationController,
              hintText: "Location",
              prefixIcon: const Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Phone Number"),
            CustomTextFormField(
              controller: phoneController,
              hintText: "Phone",
              textInputType: TextInputType.number,
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            const SizedBox(height: 12),
            _buildFieldLabel("Password"),
            CustomTextFormField(
              controller: passwordController,
              hintText: "Password",
              textInputType: TextInputType.text,
              readOnly: true,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: TextButton(onPressed: (){
                GoRouter.of(context).push(
                  AppRouter.kChangePasswordRequestView,
                  extra: {
                    'cubit': BlocProvider.of<ProfileCubit>(context),
                  },
                );
              }, child: Text(
                'Reset'
              )) ,
            ),
            const SizedBox(height: 12),
            _buildFieldLabel("Years of Experience"),
            CustomTextFormField(
              controller: experienceController,
              hintText: "Experience",
              textInputType: TextInputType.number,
              prefixIcon: const Icon(Icons.timer_outlined),
            ),
            const SizedBox(height: 26),
            BlocBuilder<ProfileCubit, ProfileStates>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: (isChanged && state is! EditProfileLoading)
                      ? () {
                    final Map<String, dynamic> updatedData = {};
                    if (firstNameController.text.trim() !=
                        widget.user.userData!.accountInfo!.firstName) {
                      updatedData["first_name"] = firstNameController.text.trim();
                    }
                    if (lastNameController.text.trim() !=
                        widget.user.userData!.accountInfo!.lastName) {
                      updatedData["last_name"] = lastNameController.text.trim();
                    }
                    if (emailController.text.trim() !=
                        widget.user.userData!.accountInfo!.email) {
                      updatedData["email"] = emailController.text.trim();
                    }
                    if (phoneController.text.trim() !=
                        (widget.user.userData!.accountInfo!.phone ?? "")) {
                      updatedData["phone_number"] = phoneController.text.trim();
                    }
                    if (bioController.text.trim() != (widget.user.bio ?? "")) {
                      updatedData["bio"] = bioController.text.trim();
                    }
                    if (experienceController.text.trim() !=
                        (widget.user.yearsOfExperience?.toString() ?? "0")) {
                      updatedData["years_of_experience"] = experienceController.text.trim();
                    }

                    context.read<ProfileCubit>().editProfile(
                      token: ApiConstants.token!,
                      id: ApiConstants.id!,
                      data: updatedData,
                    );
                  }
                      : null,
                  backgroundColor: isChanged ? kPrimaryColor : Colors.grey,
                  borderRadius: 8,
                  text: state is EditProfileLoading ? "Saving..." : "Save Changes",
                  textStyle: Styles.textStyle16.copyWith(color: Colors.white),
                );
              },
            ),
            const SizedBox(height: 12),
            Text(
              "Your profile updates will be visible to your community instantly.",
              textAlign: TextAlign.center,
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label,
          style: Styles.textStyle15.copyWith(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
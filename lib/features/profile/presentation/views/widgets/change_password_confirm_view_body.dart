import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/functions/show_snack_bar.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/profile_cubit.dart';
import '../../manager/profile_states.dart';

class ChangePasswordConfirmViewBody extends StatefulWidget {
  const ChangePasswordConfirmViewBody({super.key});

  @override
  State<ChangePasswordConfirmViewBody> createState() =>
      _ChangePasswordConfirmViewBodyState();
}

class _ChangePasswordConfirmViewBodyState
    extends State<ChangePasswordConfirmViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: Styles.textStyle18),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ResetPasswordConfirmSuccess) {
            showSnackBar(
              context: context,
              message: 'Password Changed Successfully',
              color: Colors.green,
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (state is ResetPasswordRequestLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 24,
              bottom: 50,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: newPasswordController,
                    hintText: 'New Password',
                    obsecureText: true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm New Password',
                    obsecureText: true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Change Password',
                    backgroundColor: kPrimaryColor,
                    borderRadius: 8,
                    textStyle: Styles.textStyle16.copyWith(color: Colors.white),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ProfileCubit.get(context).resetPasswordConfirm(
                          password: newPasswordController.text,
                        );
                      }
                    },
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

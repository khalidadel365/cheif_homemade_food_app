import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../../../core/utilities/app_router.dart';
import '../../../../../core/utilities/functions/show_snack_bar.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/profile_cubit.dart';
import '../../manager/profile_states.dart';

class ChangePasswordRequestViewBody extends StatelessWidget {
  ChangePasswordRequestViewBody({Key? key}) : super(key: key);
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocListener<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ResetPasswordRequestFailure) {
          print('**********fail}');
          showSnackBar(
            context: context,
            message: '${state.errMessage}',
            color: Colors.red,
          );
        } else if (state is ResetPasswordRequestSuccess) {
          print('valiid emaiiill');
          GoRouter.of(context).push(
            AppRouter.kChangePasswordConfirmView,
            extra: {'cubit': BlocProvider.of<ProfileCubit>(context)},
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Change Password', style: Styles.textStyle18),
            centerTitle: true,
          ),
          body: BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              if (state is ResetPasswordRequestLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Your Email Address',
                          style: Styles.textStyle14,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Examble@gmail.com',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Email is required';
                            } else {
                              return null;
                            }
                          },
                          hintTextStyle: TextStyle(color: Colors.grey),
                        ),
                        const Spacer(),
                        CustomButton(
                          width: double.infinity,
                          text: 'Change Password',
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: kPrimaryColor,
                          borderRadius: 15,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ProfileCubit.get(context).resetPasswordRequest(
                                token: ApiConstants.token!,
                                email: emailController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

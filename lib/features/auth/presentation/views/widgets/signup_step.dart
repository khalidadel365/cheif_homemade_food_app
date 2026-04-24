import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/app_router.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/auth_cubit.dart';

class SignupStep extends StatefulWidget {
  final PageController pageController;

  const SignupStep({super.key, required this.pageController});

  @override
  State<SignupStep> createState() => _SignupStepState();
}

class _SignupStepState extends State<SignupStep> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //first name text field
            CustomTextFormField(
              hintText: "First Name",
              prefixIcon: Icon(
                Icons.person_outline,
                size: 23,
                color: Colors.grey.shade700,
              ),
              validate: (value) {
                if (value.isEmpty) {
                  return 'First name must not be empty';
                }
                return null;
              },
              controller: firstNameController,
            ),
            const SizedBox(height: 16),
            //last name text field
            CustomTextFormField(
              hintText: "Last Name",
              prefixIcon: Icon(
                Icons.person_outline,
                size: 23,
                color: Colors.grey.shade700,
              ),
              validate: (value) {
                if (value.isEmpty) {
                  return 'Last name must not be empty';
                }
                return null;
              },
              controller: lastNameController,
            ),
            const SizedBox(height: 16),
            // phone text field
            CustomTextFormField(
              hintText: "Phone Number",
              prefixIcon: Icon(
                Icons.phone_outlined,
                size: 23,
                color: Colors.grey.shade700,
              ),
              validate: (value) {
                if (value.isEmpty) {
                  return 'Phone number must not be empty';
                }
                return null;
              },
              controller: phoneController,
            ),
            const SizedBox(height: 16),
            // email text field
            CustomTextFormField(
              hintText: "Email Address",
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 22,
                color: Colors.grey.shade700,
              ),
              validate: (value) {
                if (value.isEmpty) {
                  return 'Email must not be empty';
                }
                return null;
              },
              controller: emailController,
            ),
            const SizedBox(height: 16),
            // password text field
            CustomTextFormField(
              hintText: "Password",
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 22,
                color: Colors.grey.shade700,
              ),
              obsecureText: true,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Password must not be empty';
                }
                return null;
              },
              controller: passwordController,
            ),
            const SizedBox(height: 15),
            // confirm Password text field
            CustomTextFormField(
              hintText: "Confirm Password",
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 22,
                color: Colors.grey.shade700,
              ),
              controller: confirmPasswordController,
              obsecureText: true,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Confirm password must not be empty';
                } else if (value != passwordController.text) {
                  return 'Passwords do not match';
                } else
                  return null;
              },
            ),
            const SizedBox(height: 50),
            // sign up button
            CustomButton(
              width: double.infinity,
              height: 53,
              backgroundColor: kPrimaryColor,
              borderRadius: 12,
              text: 'Continue',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var cubit = AuthCubit.get(context);
                  cubit.email = emailController.text;
                  cubit.password = passwordController.text;
                  cubit.firstName = firstNameController.text;
                  cubit.lastName = lastNameController.text;
                  cubit.phone = phoneController.text;
                  widget.pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              textStyle: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: Styles.textStyle14),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.kLoginView);
                  },
                  child: Text("Login", style: Styles.textStyleBold15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

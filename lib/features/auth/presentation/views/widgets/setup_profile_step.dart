import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/functions/build_field_title.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/auth_cubit.dart';
import '../../manager/auth_states.dart';

class SetupProfileStep extends StatefulWidget {
  final PageController pageController;

  const SetupProfileStep({super.key, required this.pageController});

  @override
  State<SetupProfileStep> createState() => _SetupProfileStepState();
}

class _SetupProfileStepState extends State<SetupProfileStep> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController experienceController;
  late final TextEditingController descriptionController;
  late final TextEditingController addressController;

  @override
  void initState() {
    experienceController = TextEditingController();
    descriptionController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    experienceController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //image
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: kPrimaryColor.withOpacity(0.05),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 40,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: kPrimaryColor.withOpacity(0.08),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Upload Photo",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                BuildFieldTitle("Years of Experience"),
                CustomTextFormField(
                  hintText: "e.g., 5 years",
                  hintTextStyle: Styles.textStyleBold15.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  controller: experienceController,
                  textInputType: TextInputType.number,
                  validate: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                BuildFieldTitle("Bio"),
                CustomTextFormField(
                  hintTextStyle: Styles.textStyleBold15.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  hintText: "Share your story, culinary skills, or what makes your food unique...",
                  maxLines: 4,
                  controller: descriptionController,
                  validate: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                BuildFieldTitle("Full Address"),
                CustomTextFormField(
                  hintText: "Enter your business address",
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  controller: addressController,
                  validate: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  width: double.infinity,
                  height: 53,
                  text: 'Continue',
                  textStyle: Styles.textStyle14.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: kPrimaryColor,
                  borderRadius: 30,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var cubit = AuthCubit.get(context);
                      cubit.bio = descriptionController.text;
                      cubit.yearsOfExperience = int.parse(experienceController.text);
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  };
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

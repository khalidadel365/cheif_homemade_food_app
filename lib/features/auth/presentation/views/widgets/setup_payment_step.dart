import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants.dart';
import '../../../../../core/utilities/functions/build_field_title.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../manager/auth_cubit.dart';
import '../../manager/auth_states.dart';

class SetupPaymentStep extends StatefulWidget {
  const SetupPaymentStep({super.key});

  @override
  State<SetupPaymentStep> createState() => _SetupPaymentStepState();
}

class _SetupPaymentStepState extends State<SetupPaymentStep> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController cardNumberController;
  late final TextEditingController cardHolderController;
  late final TextEditingController expiryController;
  late final TextEditingController cvvController;

  @override
  void initState() {
    cardNumberController = TextEditingController();
    cardHolderController = TextEditingController();
    expiryController = TextEditingController();
    cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Securely add your payment method to start selling.",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                BuildFieldTitle("Visa Card Number"),
                CustomTextFormField(
                  hintText: "1234 5678 9101 1121",
                  controller: cardNumberController,
                  suffixIcon: const Icon(
                    Icons.credit_card,
                    color: kPrimaryColor,
                  ),
                  textInputType: TextInputType.number,
                  validate: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                BuildFieldTitle("Cardholder Name"),
                CustomTextFormField(
                  hintText: "Enter name as it appears on card",
                  controller: cardHolderController,
                  validate: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                // Expiry Date and CVV
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          BuildFieldTitle("Expiry Date"),
                          CustomTextFormField(
                            hintText: "MM/YY",
                            controller: expiryController,
                            validate: (val) => val!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          BuildFieldTitle("CVV"),
                          CustomTextFormField(
                            hintText: "123",
                            controller: cvvController,
                            textInputType: TextInputType.number,
                            validate: (val) => val!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 65),

                // Security Note
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Your information is securely encrypted.",
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                CustomButton(
                  width: double.infinity,
                  height: 53,
                  text: 'Save Payment Details',
                  textStyle: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  backgroundColor: kPrimaryColor,
                  borderRadius: 12,
                  onPressed: () {
                    var cubit = AuthCubit.get(context);
                    if (formKey.currentState!.validate()) {
                      AuthCubit.get(context).setupProfile(
                        email: cubit.email ?? '',
                        password: cubit.password ?? '',
                        firstName: cubit.firstName ?? '',
                        lastName: cubit.lastName ?? '',
                        phone: cubit.phone ?? '',
                        yearsOfExp: cubit.yearsOfExperience ?? 0,
                        bio: cubit.bio ?? '',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

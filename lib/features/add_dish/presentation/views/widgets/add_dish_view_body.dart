import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';

class AddDishViewBody extends StatefulWidget {
  const AddDishViewBody({super.key});

  @override
  State<AddDishViewBody> createState() => _AddDishViewBodyState();
}

class _AddDishViewBodyState extends State<AddDishViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();

  bool isCurrentlyOffering = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text("Dish Name", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _nameController,
                hintText: "e.g., Lasagna al Forno",
                validate: (value) {
                  if (value == null || value.isEmpty) return 'Please enter dish name';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Dish Description", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _descController,
                hintText: "Describe your dish...",
                maxLines: 4,
                validate: (value) {
                  if (value == null || value.isEmpty) return 'Please enter description';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _priceController,
                          hintText: "\$ 0.00",
                          textInputType: TextInputType.number,
                          validate: (value) {
                            if (value == null || value.isEmpty) return 'Required';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Prep Time", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _prepTimeController,
                          hintText: "e.g., 30",
                          textInputType: TextInputType.number,
                          validate: (value) {
                            if (value == null || value.isEmpty) return 'Required';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Currently Offering",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: isCurrentlyOffering,
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
                          setState(() {
                            isCurrentlyOffering = val;
                          });
                          // context
                          //     .read<ProfileCubit>()
                          //     .toggleChefStatus(
                          //   token: ApiConstants.token!,
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                backgroundColor: kPrimaryColor,
                borderRadius: 16,
                text: 'Save Dish',
                textStyle: Styles.textStyle16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saving Dish...')),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}


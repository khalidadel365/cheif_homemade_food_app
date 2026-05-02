import 'package:cheif_homemade_food/features/add_dish/presentation/views/widgets/dynamic_variety_view.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/models/category_model.dart';
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
  List<SectionModel> sections = [];
  int? selectedCategoryId;

  final List<CategoryModel> categories = [
    CategoryModel(
      id: 4,
      name: "American",
      description: "Classic American comfort food",
      dishCount: 3,
    ),
    CategoryModel(
      id: 3,
      name: "Asian",
      description: "Fusion Asian cuisine",
      dishCount: 7,
    ),
    CategoryModel(
      id: 1,
      name: "Italian",
      description: "Authentic Italian cuisine",
      dishCount: 4,
    ),
    CategoryModel(
      id: 2,
      name: "Mexican",
      description: "Traditional Mexican dishes",
      dishCount: 0,
    ),
  ];

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
              const Text(
                "Dish Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _nameController,
                hintText: "e.g., Lasagna al Forno",
                validate:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Dish name is required'
                            : null,
              ),
              const SizedBox(height: 16),
              const Text(
                "Dish Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _descController,
                hintText: "Describe your dish...",
                maxLines: 4,
                validate:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Description is required'
                            : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Dish Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              DropdownMenu<int>(
                width: MediaQuery.of(context).size.width - 32,
                hintText: "Select Category",

                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey[50],
                  hintStyle: TextStyle(color: Colors.grey[700]),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 2,
                    ),
                  ),
                ),

                menuStyle: MenuStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  elevation: WidgetStateProperty.all(8),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                textStyle: const TextStyle(color: Colors.black, fontSize: 16),

                onSelected: (int? id) {
                  setState(() {
                    selectedCategoryId = id;
                  });
                },

                dropdownMenuEntries:
                    categories.map((category) {
                      return DropdownMenuEntry<int>(
                        value: category.id!,
                        label: category.name!,
                        style: MenuItemButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                      );
                    }).toList(),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _priceController,
                          hintText: "\$ 0.00",
                          textInputType: TextInputType.number,
                          validate:
                              (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Price is required'
                                      : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Prep Time (min)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _prepTimeController,
                          hintText: "e.g., 30",
                          textInputType: TextInputType.number,
                          validate:
                              (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Prep time is required'
                                      : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Currently Offering",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
                        onChanged: (val) => setState(() => isCurrentlyOffering = val),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // الـ View الديناميكي للسيكشنز والخيارات
              DynamicVarietyView(
                sections: sections,
                onAddSection:
                    () => setState(() => sections.add(SectionModel())),
                onRemoveSection:
                    (index) => setState(() => sections.removeAt(index)),
                onRefresh: () => setState(() {}),
              ),

              const SizedBox(height: 40),

              // زرار الحفظ النهائي وتجميع الـ Payload
              CustomButton(
                text: 'Save Dish',
                textStyle: Styles.textStyle16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedCategoryId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a category"),
                        ),
                      );
                      return;
                    }

                    final payload = {
                      "category_id": selectedCategoryId,
                      "name": _nameController.text,
                      "description": _descController.text,
                      "price": double.tryParse(_priceController.text),
                      "prep_time": int.tryParse(_prepTimeController.text),
                      "is_offering": isCurrentlyOffering,
                      "sections":
                          sections
                              .map(
                                (s) => {
                                  "name": s.nameController.text,
                                  "required": s.isRequired,
                                  "options":
                                      s.varieties
                                          .map(
                                            (v) => {
                                              "name": v.nameController.text,
                                              "price":
                                                  double.tryParse(
                                                    v.priceController.text,
                                                  ) ??
                                                  0.0,
                                            },
                                          )
                                          .toList(),
                                },
                              )
                              .toList(),
                    };

                    print("Ready to send: $payload");
                  }
                },
                backgroundColor: kPrimaryColor,
                borderRadius: 14,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

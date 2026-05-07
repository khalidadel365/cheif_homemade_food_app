import 'package:cheif_homemade_food/features/edit_dish/presentation/manager/edit_dish_cubit.dart';
import 'package:cheif_homemade_food/features/edit_dish/presentation/manager/edit_dish_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_textformfield.dart';

class EditDishViewBody extends StatefulWidget {
  const EditDishViewBody({super.key});
  @override
  State<EditDishViewBody> createState() => _EditDishViewBodyState();
}

class _EditDishViewBodyState extends State<EditDishViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dishNameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();

  int? selectedCategoryId;
  String? currentImageUrl;

  @override
  void dispose() {
    _dishNameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditDishCubit, EditDishStates>(
      listener: (context, state) {
        if (state is FetchDishDetailsSuccessState) {
          _dishNameController.text = state.dish.name ?? '';
          _descController.text = state.dish.description ?? '';
          _priceController.text = state.dish.price.toString();
          _prepTimeController.text = state.dish.preparationTime ?? '';
          selectedCategoryId = state.dish.categoryId;
          currentImageUrl = state.dish.imageUrl;
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditDishCubit>();

        if (state is FetchDishDetailsLoadingState ||
            state is GetCategoriesLoadingState ||
            cubit.categories == null ||
            cubit.currentDish == null) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        }

        if (state is FetchDishDetailsFailureState) {
          return Center(child: Text(state.errMessage));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFieldLabel("Dish Photo"),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              currentImageUrl ?? '',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                              const EdgeInsets.only(bottom: 8, right: 8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFieldLabel("Dish Name"),
                  CustomTextFormField(
                    controller: _dishNameController,
                    hintText: "e.g., Pizza",
                    validate: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildFieldLabel("Dish Description"),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _descController,
                    hintText: "Describe your dish...",
                    maxLines: 4,
                    validate: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildPriceAndTimeFields(),
                  const SizedBox(height: 16),
                  _buildFieldLabel("Dish Category"),
                  _buildCategoryDropdown(cubit.categories ?? []),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryDropdown(List categories) {
    return DropdownMenu<int>(
      initialValue: selectedCategoryId,
      width: MediaQuery.of(context).size.width - 32,
      hintText: "Select Category",
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
        ),
      ),
      onSelected: (int? id) => setState(() => selectedCategoryId = id),
      dropdownMenuEntries: categories.map((category) {
        return DropdownMenuEntry<int>(
          value: category.id!,
          label: category.name!,
        );
      }).toList(),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label,
          style: Styles.textStyle15.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceAndTimeFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price (EGY)",
                style: Styles.textStyle15.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _priceController,
                hintText: "0.00",
                textInputType: TextInputType.number,
                validate: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prep Time (min)",
                style: Styles.textStyle15.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _prepTimeController,
                hintText: "30",
                textInputType: TextInputType.number,
                validate: (value) =>
                (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
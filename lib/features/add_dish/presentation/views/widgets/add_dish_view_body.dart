import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/features/add_dish/presentation/manager/add_dish_cubit.dart';
import 'package:cheif_homemade_food/features/add_dish/presentation/manager/add_dish_states.dart';
import 'package:cheif_homemade_food/features/add_dish/presentation/views/widgets/dynamic_variety_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../constants.dart';
import '../../../../../core/utilities/functions/show_snack_bar.dart';
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
    return BlocConsumer<AddDishCubit, AddDishStates>(
      listener: (context, state) {
        if (state is AddDishSuccessState) {
          showSnackBar(
            context: context,
            message: 'Dish added successfully!',
            color: Colors.green,
          );
          Navigator.pop(context);
        } else if (state is AddDishErrorState) {
          showSnackBar(
            context: context,
            message: state.error,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _buildMainContent(context, state),
            if (state is AddDishLoadingState)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(
                  child: SpinKitPulse(color: kPrimaryColor, size: 50.0),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context, AddDishStates state) {
    if (state is GetCategoriesLoadingState) {
      return const Center(
        child: SpinKitPulse(color: kPrimaryColor, size: 50.0),
      );
    } else if (state is GetCategoriesErrorState) {
      return Center(
        child: Text(state.error, style: const TextStyle(color: Colors.red)),
      );
    }

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
                hintText: "e.g., Pizza",
                validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text("Dish Description", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _descController,
                hintText: "Describe your dish...",
                maxLines: 4,
                validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Dish Category', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildCategoryDropdown(state),
              const SizedBox(height: 16),
              _buildPriceAndTimeFields(),
              const SizedBox(height: 24),
              _buildOfferingSwitch(),
              const SizedBox(height: 32),
              DynamicVarietyView(
                sections: sections,
                onAddSection: () => setState(() => sections.add(SectionModel())),
                onRemoveSection: (index) => setState(() => sections.removeAt(index)),
                onRefresh: () => setState(() {}),
              ),
              const SizedBox(height: 40),
              _buildSaveButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(AddDishStates state) {
    List<DropdownMenuEntry<int>> entries = [];
    if (state is GetCategoriesSuccessState) {
      entries = state.categories.map((category) {
        return DropdownMenuEntry<int>(
          value: category.id!,
          label: category.name!,
        );
      }).toList();
    }

    return DropdownMenu<int>(
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
      dropdownMenuEntries: entries,
    );
  }

  Widget _buildPriceAndTimeFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _priceController,
                hintText: "0.00",
                textInputType: TextInputType.number,
                validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Prep Time (min)", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _prepTimeController,
                hintText: "30",
                textInputType: TextInputType.number,
                validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferingSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Currently Offering", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Switch(
            value: isCurrentlyOffering,
            trackOutlineColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            thumbColor: WidgetStateProperty.all(Colors.white),
            activeTrackColor: kPrimaryColor,
            inactiveTrackColor: Colors.grey[300],
            onChanged:(val) => setState(() => isCurrentlyOffering = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CustomButton(
      text: 'Save Dish',
      textStyle: Styles.textStyle16.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      onPressed: () {
        if (_formKey.currentState!.validate() && selectedCategoryId != null) {
          final payload = {
            "name": _nameController.text,
            "description": _descController.text,
            "price": double.tryParse(_priceController.text),
            "preparation_time": int.tryParse(_prepTimeController.text),
            "category_id": selectedCategoryId,
            "variety_sections": sections.map((s) => {
              "name": s.nameController.text,
              "is_required": s.isRequired,
              "options": s.varieties.map((v) => {
                "name": v.nameController.text,
                "price_adjustment": double.tryParse(v.priceController.text) ?? 0.0,
              }).toList(),
            }).toList(),
          };

          context.read<AddDishCubit>().addDish(
            dishData: payload,
            token: ApiConstants.token!,
          );
        } else if (selectedCategoryId == null) {
          showSnackBar(context: context, message: 'Category is required', color: Colors.red);
        }
      },
      backgroundColor: kPrimaryColor,
      borderRadius: 14,
    );
  }
}
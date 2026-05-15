import 'dart:io';
import 'package:cheif_homemade_food/features/edit_dish/presentation/manager/edit_dish_cubit.dart';
import 'package:cheif_homemade_food/features/edit_dish/presentation/manager/edit_dish_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../constants.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textformfield.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../../../core/utilities/functions/show_snack_bar.dart';
import '../../../../../core/utilities/image_helper.dart';
import '../../../../add_dish/presentation/views/widgets/dynamic_variety_view.dart';

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
  XFile? pickedImageFile;
  List<SectionModel> sections = [];
  bool isInitialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _dishNameController.addListener(_updateState);
    _descController.addListener(_updateState);
    _priceController.addListener(_updateState);
    _prepTimeController.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _dishNameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  bool _checkIfVarietyChanged(EditDishCubit cubit) {
    final original = cubit.currentDish?.varietySections ?? [];
    if (original.length != sections.length) return true;

    for (int i = 0; i < sections.length; i++) {
      final oSec = original[i];
      final cSec = sections[i];

      if (cSec.nameController.text.trim() != (oSec.name ?? '').trim() ||
          cSec.isRequired != (oSec.isRequired ?? false) ||
          cSec.varieties.length != (oSec.options?.length ?? 0)) {
        return true;
      }

      for (int j = 0; j < cSec.varieties.length; j++) {
        final oOpt = oSec.options![j];
        final cOpt = cSec.varieties[j];

        double currentPrice =
            double.tryParse(cOpt.priceController.text.trim()) ?? 0.0;
        double originalPrice =
            double.tryParse(oOpt.priceAdjustment?.toString() ?? '0.0') ?? 0.0;

        if (cOpt.nameController.text.trim() != (oOpt.name ?? '').trim() ||
            currentPrice != originalPrice) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditDishCubit, EditDishStates>(
      listener: (context, state) {
        if (state is FetchDishDetailsSuccessState) {
          _dishNameController.text = state.dish.name ?? '';
          _descController.text = state.dish.description ?? '';
          _priceController.text = state.dish.price?.toString() ?? '';
          _prepTimeController.text =
              state.dish.preparationTime?.toString() ?? '';
          selectedCategoryId = state.dish.category?.id;
          currentImageUrl = state.dish.imageUrl;

          if (!isInitialDataLoaded) {
            sections =
                state.dish.varietySections?.map((s) {
                  var section = SectionModel();
                  section.nameController.text = s.name ?? '';
                  section.nameController.addListener(_updateState);
                  section.isRequired = s.isRequired ?? false;
                  section.varieties =
                      s.options?.map((v) {
                        var option = VarietyOptionModel();
                        option.nameController.text = v.name ?? '';
                        option.nameController.addListener(_updateState);
                        option.priceController.text =
                            v.priceAdjustment?.toString() ?? '';
                        option.priceController.addListener(_updateState);
                        return option;
                      }).toList() ??
                      [VarietyOptionModel()];
                  return section;
                }).toList() ??
                [];
            isInitialDataLoaded = true;
            setState(() {});
          }
        }

        if (state is UpdateDishSuccessState ||
            state is UploadDishImageSuccessState) {
          showSnackBar(
            context: context,
            message: "Data Updated Successfully",
            color: Colors.green,
          );
        } else if (state is UpdateDishErrorState ||
            state is UploadDishImageErrorState) {
          showSnackBar(
            context: context,
            message: "Error updating data",
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditDishCubit>();

        if (state is FetchDishDetailsLoadingState ||
            state is GetCategoriesLoadingState ||
            cubit.categories == null ||
            cubit.currentDish == null) {
          return const Center(
            child: SpinKitPulse(color: kPrimaryColor, size: 50.0),
          );
        }

        final initialDish = cubit.currentDish!;

        bool hasChanges =
            _dishNameController.text.trim() != (initialDish.name ?? '') ||
            _descController.text.trim() != (initialDish.description ?? '') ||
            _priceController.text.trim() !=
                (initialDish.price?.toString() ?? '') ||
            _prepTimeController.text.trim() !=
                (initialDish.preparationTime?.toString() ?? '') ||
            selectedCategoryId != initialDish.category?.id ||
            pickedImageFile != null ||
            _checkIfVarietyChanged(cubit);

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildFieldLabel("Dish Photo"),
                      _buildImageSection(),
                      const SizedBox(height: 24),
                      _buildFieldLabel("Dish Name"),
                      CustomTextFormField(
                        controller: _dishNameController,
                        hintText: "e.g., Pizza",
                        validate:
                            (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      _buildFieldLabel("Dish Description"),
                      CustomTextFormField(
                        controller: _descController,
                        hintText: "Describe your dish...",
                        maxLines: 4,
                        validate:
                            (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Required'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      _buildFieldLabel("Dish Category"),
                      _buildCategoryDropdown(cubit.categories ?? []),
                      const SizedBox(height: 16),
                      _buildPriceAndTimeFields(),
                      const SizedBox(height: 24),
                      DynamicVarietyView(
                        sections: sections,
                        onAddSection: () {
                          var newSection = SectionModel();
                          newSection.nameController.addListener(_updateState);
                          newSection.varieties.first.nameController.addListener(
                            _updateState,
                          );
                          newSection.varieties.first.priceController
                              .addListener(_updateState);
                          setState(() => sections.add(newSection));
                        },
                        onRemoveSection:
                            (index) => setState(() => sections.removeAt(index)),
                        onRefresh: () => setState(() {}),
                      ),
                      const SizedBox(height: 40),
                      _buildSaveButton(hasChanges, cubit),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            if (state is UploadDishImageLoadingState ||
                state is UpdateDishLoadingState)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: SpinKitPulse(color: kPrimaryColor, size: 50.0),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                pickedImageFile != null
                    ? Image.file(
                      File(pickedImageFile!.path),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                    : Image.network(
                      currentImageUrl ?? '',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (c, e, s) => const Icon(Icons.broken_image, size: 50),
                    ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                ImageHelper.pickImageWithChoice(context).then((value) {
                  if (value != null) setState(() => pickedImageFile = value);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.file_upload_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(List categories) {
    return DropdownMenu<int>(
      initialSelection: selectedCategoryId,
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
      dropdownMenuEntries:
          categories
              .map(
                (cat) =>
                    DropdownMenuEntry<int>(value: cat.id!, label: cat.name!),
              )
              .toList(),
    );
  }

  Widget _buildSaveButton(bool hasChanges, EditDishCubit cubit) {
    return CustomButton(
      text: 'Save Changes',
      textStyle: Styles.textStyle16.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      onPressed:
          hasChanges
              ? () {
                if (_formKey.currentState!.validate()) {
                  if (pickedImageFile != null) {
                    cubit.uploadDishImage(
                      dishId: cubit.currentDish!.id!,
                      token: ApiConstants.token!,
                      imageFile: pickedImageFile!,
                    );
                  }
                  final payload = {
                    "name": _dishNameController.text.trim(),
                    "description": _descController.text.trim(),
                    "price": double.tryParse(_priceController.text),
                    "preparation_time": int.tryParse(_prepTimeController.text),
                    "category_id": selectedCategoryId,
                    "variety_sections":
                        sections
                            .map(
                              (s) => {
                                "name": s.nameController.text.trim(),
                                "is_required": s.isRequired,
                                "options":
                                    s.varieties
                                        .map(
                                          (v) => {
                                            "name":
                                                v.nameController.text.trim(),
                                            "price_adjustment":
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
                  cubit.updateDish(
                    dishId: cubit.currentDish!.id!,
                    token: ApiConstants.token!,
                    dishData: payload,
                  );
                }
              }
              : null,
      backgroundColor: hasChanges ? kPrimaryColor : Colors.grey,
      borderRadius: 14,
    );
  }

  Widget _buildFieldLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );

  Widget _buildPriceAndTimeFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel("Price (EGY)"),
              CustomTextFormField(
                controller: _priceController,
                hintText: "0.00",
                textInputType: TextInputType.number,
                validate:
                    (value) =>
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
              _buildFieldLabel("Prep Time (min)"),
              CustomTextFormField(
                controller: _prepTimeController,
                hintText: "30",
                textInputType: TextInputType.number,
                validate:
                    (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

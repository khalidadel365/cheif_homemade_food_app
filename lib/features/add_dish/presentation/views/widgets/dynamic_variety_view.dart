import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../core/widgets/custom_textformfield.dart';

class VarietyOptionModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
}

class SectionModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isRequired = false;
  List<VarietyOptionModel> varieties = [VarietyOptionModel()];
}

class DynamicVarietyView extends StatelessWidget {
  final List<SectionModel> sections;
  final VoidCallback onAddSection;
  final Function(int) onRemoveSection;
  final VoidCallback onRefresh;

  const DynamicVarietyView({
    super.key,
    required this.sections,
    required this.onAddSection,
    required this.onRemoveSection,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...sections.asMap().entries.map((entry) {
          return buildSectionForm(entry.key, context);
        }).toList(),
        const SizedBox(height: 8,),
        Align(
          alignment: Alignment.bottomRight,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5
            )),
            onPressed: onAddSection,
            icon: const Icon(Icons.add, color: kPrimaryColor),
            label: const Text("Add New Section", style: TextStyle(color: kPrimaryColor)),
          ),
        ),
      ],
    );
  }

  Widget buildSectionForm(int sIndex, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: sections[sIndex].isRequired,
                  trackOutlineColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  activeTrackColor: kPrimaryColor,
                  inactiveTrackColor: Colors.grey[300],
                  onChanged: (val) {
                    sections[sIndex].isRequired = val;
                    onRefresh();
                    // context
                    //     .read<ProfileCubit>()
                    //     .toggleChefStatus(
                    //   token: ApiConstants.token!,
                    // );
                  },
                ),
              ),
              const Text("Required", style: TextStyle(fontWeight: FontWeight.w500)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => onRemoveSection(sIndex),
              ),
            ],
          ),
          const Text("Section Name *", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: sections[sIndex].nameController,
            hintText: "e.g., Choose your bread",
            validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          const Text("Variety Options", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sections[sIndex].varieties.length,
            itemBuilder: (context, vIndex) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        controller: sections[sIndex].varieties[vIndex].nameController,
                        hintText: "Option name",
                        validate: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        controller: sections[sIndex].varieties[vIndex].priceController,
                        hintText: "Price",
                        textInputType: TextInputType.number,
                      ),
                    ),
                    if (sections[sIndex].varieties.length > 1)
                      IconButton(
                        icon: const Icon(Icons.close, size: 20, color: Colors.red),
                        onPressed: () {
                          sections[sIndex].varieties.removeAt(vIndex);
                          onRefresh();
                        },
                      ),
                  ],
                ),
              );
            },
          ),
          TextButton.icon(
            onPressed: () {
              sections[sIndex].varieties.add(VarietyOptionModel());
              onRefresh();
            },
            icon: const Icon(Icons.add_circle_outline, size: 20, color: kPrimaryColor),
            label: const Text("Add New Variety", style: TextStyle(color: kPrimaryColor)),
          ),
        ],
      ),
    );
  }
}
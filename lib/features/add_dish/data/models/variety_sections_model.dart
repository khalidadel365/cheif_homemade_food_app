import 'options_model.dart';

class VarietySectionsModel {
  final int? id;
  final String? name;
  final String? description;
  final bool? isRequired;
  final List<OptionsModel>? options;

  VarietySectionsModel({
    this.id,
    this.name,
    this.description,
    this.isRequired,
    this.options,
  });

  factory VarietySectionsModel.fromJson(Map<String, dynamic> json) {
    return VarietySectionsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isRequired: json['is_required'] as bool?,
      options:
          (json['options'] as List?)
              ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_required': isRequired,
      'options': options?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryModel {
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final int? dishCount;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.dishCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      dishCount: json['dish_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'dish_count': dishCount,
    };
  }
}

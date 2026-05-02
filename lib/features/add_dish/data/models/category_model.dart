class CategoryModel {
  final int id;
  final String name;
  final String description;
  final int dishCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.dishCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dishCount: json['dish_count'],
    );
  }
}
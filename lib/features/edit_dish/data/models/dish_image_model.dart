class DishImageModel {
  final int? id;
  final String? image;
  final String? imageUrl;
  final bool? isPrimary;
  final String? createdAt;
  final String? updatedAt;

  DishImageModel({
    this.id,
    this.image,
    this.imageUrl,
    this.isPrimary,
    this.createdAt,
    this.updatedAt,
  });

  factory DishImageModel.fromJson(Map<String, dynamic> json) {
    return DishImageModel(
      id: json['id'] as int?,
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
      isPrimary: json['is_primary'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'image_url': imageUrl,
      'is_primary': isPrimary,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

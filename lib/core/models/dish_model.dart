import '../../../../core/utilities/api_constants.dart';
import '../../features/add_dish/data/models/reviews_preview_model.dart';
import '../../features/add_dish/data/models/variety_sections_model.dart';
import '../utilities/string_extensions.dart';
import 'category_model.dart';
import 'chef_model.dart';

class DishModel {
  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final bool? isAvailable;
  final int? preparationTime;
  final ChefModel? chef;
  final String? chefName;
  final CategoryModel? category;
  final String? createdAt;
  final double? averageRating;
  final String? imageUrl;
  final int? reviewsCount;
  final List<VarietySectionsModel>? varietySections;
  final List<ReviewsPreviewModel>? reviewsPreview;

  DishModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.isAvailable,
    this.preparationTime,
    this.chef,
    this.chefName,
    this.category,
    this.createdAt,
    this.averageRating,
    this.imageUrl,
    this.reviewsCount,
    this.varietySections,
    this.reviewsPreview,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    final chefObject = json['chef'] != null ? ChefModel.fromJson(json['chef']) : null;

    String? rawImageUrl;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      var primaryImage = (json['images'] as List).firstWhere(
            (img) => img['is_primary'] == true,
        orElse: () => (json['images'] as List)[0],
      );
      rawImageUrl = primaryImage['image_url'] ?? primaryImage['image'];
    } else {
      rawImageUrl = json['image'] ?? json['image_url'];
    }

    String? finalImageUrl;
    if (rawImageUrl != null) {
      if (rawImageUrl.contains('http')) {
        finalImageUrl = rawImageUrl.toCleanImageUrl();
      } else {
        String cleanPath = rawImageUrl.startsWith('/') ? rawImageUrl.substring(1) : rawImageUrl;
        finalImageUrl = "${ApiConstants.baseUrl}$cleanPath";
      }
    }

    return DishModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price']?.toString(),
      description: json['description'] as String?,
      isAvailable: json['is_available'] as bool?,
      preparationTime: json['preparation_time'] as int?,
      reviewsCount: json['reviews_count'] as int?,
      createdAt: json['created_at'] as String?,
      chefName: json['chef_name'] as String? ?? chefObject?.fullName,
      chef: chefObject,
      imageUrl: finalImageUrl,
      averageRating: (json['rating_avg'] ?? json['average_rating']) != null
          ? double.tryParse((json['rating_avg'] ?? json['average_rating']).toString())
          : null,
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
      varietySections: (json['variety_sections'] as List?)
          ?.map((e) => VarietySectionsModel.fromJson(e))
          .toList(),
      reviewsPreview: (json['reviews_preview'] as List?)
          ?.map((e) => ReviewsPreviewModel.fromJson(e))
          .toList(),
    );
  }

  DishModel copyWith({
    int? id,
    String? name,
    String? price,
    String? description,
    bool? isAvailable,
    int? preparationTime,
    String? imageUrl,
    double? averageRating,
  }) {
    return DishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      preparationTime: preparationTime ?? this.preparationTime,
      imageUrl: imageUrl ?? this.imageUrl,
      chef: this.chef,
      chefName: this.chefName,
      category: this.category,
      createdAt: this.createdAt,
      averageRating: averageRating ?? this.averageRating,
      reviewsCount: this.reviewsCount,
      varietySections: this.varietySections,
      reviewsPreview: this.reviewsPreview,
    );
  }
}
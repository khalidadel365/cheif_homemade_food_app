class ReviewsPreviewModel {
  final int? id;
  final String? userName;
  final double? rating;
  final String? reviewText;
  final String? createdAt;

  ReviewsPreviewModel({
    this.id,
    this.userName,
    this.rating,
    this.reviewText,
    this.createdAt,
  });

  factory ReviewsPreviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewsPreviewModel(
      id: json['id'] as int?,
      userName: json['user_name'] as String?,
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewText: json['review_text'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'rating': rating,
      'review_text': reviewText,
      'created_at': createdAt,
    };
  }
}

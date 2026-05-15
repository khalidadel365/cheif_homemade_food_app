class UpdateOrderStatusModel {
  final String? status;
  final int? estimatedPreparationMinutes;

  UpdateOrderStatusModel({
    this.status,
    this.estimatedPreparationMinutes,
  });

  factory UpdateOrderStatusModel.fromJson(Map<String, dynamic> json) {
    return UpdateOrderStatusModel(
      status: json['status'] as String?,
      estimatedPreparationMinutes: json['estimated_preparation_minutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (status != null) data['status'] = status;
    if (estimatedPreparationMinutes != null) {
      data['estimated_preparation_minutes'] = estimatedPreparationMinutes;
    }

    return data;
  }
}
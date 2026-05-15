class OptionsModel {
  final int? id;
  final String? name;
  final String? priceAdjustment;
  final bool? isAvailable;

  OptionsModel({this.id, this.name, this.priceAdjustment, this.isAvailable});

  factory OptionsModel.fromJson(Map<String, dynamic> json) {
    return OptionsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      priceAdjustment: json['price_adjustment'] as String?,
      isAvailable: json['is_available'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price_adjustment': priceAdjustment,
      'is_available': isAvailable,
    };
  }
}

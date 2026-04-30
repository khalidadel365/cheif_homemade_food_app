import '../../../../core/models/dish_model.dart';

class DishesResponseModel {
  final List<DishModel>? dishes;

  DishesResponseModel({this.dishes});

  factory DishesResponseModel.fromJson(dynamic json) {
    if (json is List) {
      return DishesResponseModel(
        dishes: json.map((i) => DishModel.fromJson(i)).toList(),
      );
    }

    return DishesResponseModel(
      dishes:
          (json['dishes'] as List?)?.map((i) => DishModel.fromJson(i)).toList(),
    );
  }
}

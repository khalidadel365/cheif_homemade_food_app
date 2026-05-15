import 'package:cheif_homemade_food/core/models/category_model.dart';

import '../../../../core/models/dish_model.dart';

abstract class AddDishStates {}

class AddDishInitialState extends AddDishStates {}

class AddDishLoadingState extends AddDishStates {}

class AddDishSuccessState extends AddDishStates {
  final DishModel dishes;

  AddDishSuccessState(this.dishes);
}

class AddDishErrorState extends AddDishStates {
  final String error;

  AddDishErrorState(this.error);
}

class GetCategoriesLoadingState extends AddDishStates {}

class GetCategoriesSuccessState extends AddDishStates {
  final List<CategoryModel> categories;

  GetCategoriesSuccessState(this.categories);
}

class GetCategoriesErrorState extends AddDishStates {
  final String error;

  GetCategoriesErrorState(this.error);
}

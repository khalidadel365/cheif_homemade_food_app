import '../../../../core/models/category_model.dart';
import '../../../../core/models/dish_model.dart';

abstract class EditDishStates {}
class EditDishInitialState extends EditDishStates{}
class GetCategoriesLoadingState extends EditDishStates {}

class GetCategoriesSuccessState extends EditDishStates {
  final List<CategoryModel> categories;

  GetCategoriesSuccessState(this.categories);
}

class GetCategoriesErrorState extends EditDishStates {
  final String error;

  GetCategoriesErrorState(this.error);
}
class FetchDishDetailsLoadingState extends EditDishStates {}

class FetchDishDetailsFailureState extends EditDishStates {
  final String errMessage;

  FetchDishDetailsFailureState(this.errMessage);
}

class FetchDishDetailsSuccessState extends EditDishStates {
  final DishModel dish;

  FetchDishDetailsSuccessState(this.dish);
}


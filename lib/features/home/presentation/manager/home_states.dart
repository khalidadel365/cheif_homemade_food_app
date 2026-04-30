import 'package:cheif_homemade_food/core/models/dish_model.dart';


abstract class HomeStates {}

class GetChefDishesInitialState extends HomeStates {}

class GetChefDishesLoadingState extends HomeStates {}

class GetChefDishesSuccessState extends HomeStates {
  DishModel? dishModel;
  GetChefDishesSuccessState(this.dishModel);
}

class GetChefDishesErrorState extends HomeStates {
  final String error;
  GetChefDishesErrorState(this.error);
}


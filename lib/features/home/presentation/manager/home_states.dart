
import '../../../../core/models/dish_model.dart';

abstract class HomeStates {}

class GetChefDishesInitialState extends HomeStates {}

class GetChefDishesLoadingState extends HomeStates {}

class GetChefDishesSuccessState extends HomeStates {
  final List<DishModel> dishes;
  GetChefDishesSuccessState(this.dishes);
}

class GetChefDishesErrorState extends HomeStates {
  final String error;
  GetChefDishesErrorState(this.error);
}
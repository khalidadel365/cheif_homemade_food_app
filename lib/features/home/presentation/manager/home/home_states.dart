import '../../../../../core/models/dish_model.dart';

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

class DeleteChefDishInitialState extends HomeStates {}

class DeleteChefDishLoadingState extends HomeStates {
  final int dishId;

  DeleteChefDishLoadingState(this.dishId);
}

class DeleteChefDishSuccessState extends HomeStates {
  final int dishId;

  DeleteChefDishSuccessState(this.dishId);
}

class DeleteChefDishErrorState extends HomeStates {
  final String error;

  DeleteChefDishErrorState(this.error);
}

class ChangeDishAvailabilityInitialState extends HomeStates {}

class ChangeDishAvailabilityLoadingState extends HomeStates {
  final int dishId;
  ChangeDishAvailabilityLoadingState(this.dishId);
}

class ChangeDishAvailabilitySuccessState extends HomeStates {
  final DishModel updatedDish;
  ChangeDishAvailabilitySuccessState(this.updatedDish);
}

class ChangeDishAvailabilityErrorState extends HomeStates {
  final String error;
  ChangeDishAvailabilityErrorState(this.error);
}

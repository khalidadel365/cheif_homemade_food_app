import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/dish_model.dart';
import '../../data/repos/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(GetChefDishesInitialState());

  final HomeRepo homeRepo;
  List<DishModel> chefDishes = [];

  Future<void> getChefDishes({required String token}) async {
    emit(GetChefDishesLoadingState());
    var result = await homeRepo.getChefDishes(token: token);
    result.fold(
          (failure) => emit(GetChefDishesErrorState(failure.errorMessage)),
          (dishesResponse) {
        chefDishes = dishesResponse.dishes ?? [];
        emit(GetChefDishesSuccessState(chefDishes));
      },
    );
  }

  Future<void> deleteDish({required String token, required int dishId}) async {
    emit(DeleteChefDishLoadingState(dishId));

    var result = await homeRepo.deleteChefDish(token: token, dishId: dishId);

    result.fold(
          (failure) {
        emit(DeleteChefDishErrorState(failure.errorMessage));
      },
          (_) {
        chefDishes.removeWhere((element) => element.id == dishId);

      //to stop loading then put the the new list
        emit(DeleteChefDishSuccessState(dishId));
        emit(GetChefDishesSuccessState(chefDishes));
      },
    );
  }
}
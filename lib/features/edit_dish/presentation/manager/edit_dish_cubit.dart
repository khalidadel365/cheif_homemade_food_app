import 'package:cheif_homemade_food/features/edit_dish/data/repos/edit_dish_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_dish_states.dart';

class EditDishCubit extends Cubit<EditDishStates> {
  EditDishCubit(this.editDishRepo) : super(EditDishInitialState());
  final EditDishRepo editDishRepo;

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    var result = await editDishRepo.getCategories();
    result.fold(
      (failure) => emit(GetCategoriesErrorState(failure.errorMessage)),
      (categories) {
        emit(GetCategoriesSuccessState(categories));
      },
    );
  }

  Future<void> fetchDishDetails({required int id}) async {
    emit(FetchDishDetailsLoadingState());
    var result = await editDishRepo.fetchDishDetails(dishId: id);
    result.fold(
      (failure) {
        emit(FetchDishDetailsFailureState(failure.errorMessage));
      },
      (dish) {
        emit(FetchDishDetailsSuccessState(dish));
      },
    );
  }
}

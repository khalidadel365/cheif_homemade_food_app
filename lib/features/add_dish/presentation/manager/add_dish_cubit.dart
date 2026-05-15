import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/add_dish_repo.dart';
import 'add_dish_states.dart';

class AddDishCubit extends Cubit<AddDishStates> {
  AddDishCubit(this.addDishRepo) : super(AddDishInitialState());

  final AddDishRepo addDishRepo;

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    var result = await addDishRepo.getCategories();
    result.fold(
      (failure) => emit(GetCategoriesErrorState(failure.errorMessage)),
      (categories) {
        emit(GetCategoriesSuccessState(categories));
      },
    );
  }

  Future<void> addDish({
    required Map<String, dynamic> dishData,
    required String token,
  }) async {
    emit(AddDishLoadingState());
    var result = await addDishRepo.addDish(dishData: dishData, token: token);
    result.fold((failure) => emit(AddDishErrorState(failure.errorMessage)), (
      dishModel,
    ) {
      emit(AddDishSuccessState(dishModel));
    });
  }
}

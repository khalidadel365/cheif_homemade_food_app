import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(GetChefDishesInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  Future<void> getChefDishes({required String token}) async {
    emit(GetChefDishesLoadingState());
    var result = await homeRepo.getChefDishes(token: token);
    result.fold(
      (failure) {
        emit(GetChefDishesErrorState(failure.errorMessage));
      },
      (dishModel) {
        emit(GetChefDishesSuccessState(dishModel));
      },
    );
  }
}

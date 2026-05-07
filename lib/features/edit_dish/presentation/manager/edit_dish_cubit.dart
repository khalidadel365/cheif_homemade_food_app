import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:cheif_homemade_food/features/edit_dish/data/repos/edit_dish_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_dish_states.dart';

class EditDishCubit extends Cubit<EditDishStates> {
  EditDishCubit(this.editDishRepo) : super(EditDishInitialState());
  final EditDishRepo editDishRepo;

  List<CategoryModel>? categories;
  DishModel? currentDish;

  Future<void> fetchDishDetails({required int id}) async {
    emit(FetchDishDetailsLoadingState());
    var result = await editDishRepo.fetchDishDetails(dishId: id);
    result.fold(
          (failure) => emit(FetchDishDetailsFailureState(failure.errorMessage)),
          (dish) {
        currentDish = dish;
        emit(FetchDishDetailsSuccessState(dish));
      },
    );
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    var result = await editDishRepo.getCategories();
    result.fold(
          (failure) => emit(GetCategoriesErrorState(failure.errorMessage)),
          (categoriesList) {
        categories = categoriesList;
        emit(GetCategoriesSuccessState(categoriesList));
      },
    );
  }

  Future<void> uploadDishImage({
    required int dishId,
    required String token,
    required XFile imageFile,
  }) async {
    emit(UploadDishImageLoadingState());
    var result = await editDishRepo.uploadDishImage(
      dishId: dishId,
      token: token,
      imageFile: imageFile,
    );
    result.fold(
          (failure) => emit(UploadDishImageErrorState(failure.errorMessage)),
          (uploadedImage) {
        if (currentDish != null) {
          currentDish = currentDish!.copyWith(imageUrl: uploadedImage.imageUrl);
        }
        emit(UploadDishImageSuccessState(uploadedImage));
      },
    );
  }

  Future<void> updateDish({
    required int dishId,
    required String token,
    required Map<String, dynamic> dishData,
  }) async {
    emit(UpdateDishLoadingState());
    var result = await editDishRepo.updateDish(
      dishId: dishId,
      token: token,
      dishData: dishData,
    );
    result.fold(
          (failure) => emit(UpdateDishErrorState(failure.errorMessage)),
          (updatedDish) {
        currentDish = updatedDish;
        emit(UpdateDishSuccessState(updatedDish));
      },
    );
  }
}
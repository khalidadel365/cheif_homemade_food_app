import '../../../../core/models/category_model.dart';
import '../../../../core/models/dish_model.dart';
import '../../data/models/dish_image_model.dart';

abstract class EditDishStates {}

class EditDishInitialState extends EditDishStates {}

class UpdateDishLoadingState extends EditDishStates {}

class UpdateDishSuccessState extends EditDishStates {
  final DishModel updatedDish;

  UpdateDishSuccessState(this.updatedDish);
}

class UpdateDishErrorState extends EditDishStates {
  final String error;

  UpdateDishErrorState(this.error);
}

class UploadDishImageLoadingState extends EditDishStates {}

class UploadDishImageSuccessState extends EditDishStates {
  final DishImageModel uploadedImage;

  UploadDishImageSuccessState(this.uploadedImage);
}

class UploadDishImageErrorState extends EditDishStates {
  final String error;

  UploadDishImageErrorState(this.error);
}

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

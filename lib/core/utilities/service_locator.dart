import 'package:cheif_homemade_food/features/add_dish/data/repos/add_dish_repo_imp.dart';
import 'package:cheif_homemade_food/features/edit_dish/data/repos/edit_dish_repo_imp.dart';
import 'package:cheif_homemade_food/features/home/data/repos/home_repo_imp.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo_imp.dart';

import '../../features/edit_dish/data/repos/edit_dish_repo.dart';
import '../../features/home/data/service/orders_socket_service.dart';
import '../../features/home/presentation/manager/orders/orders_cubit.dart';
import '../../features/profile/data/repos/profile_repo_imp.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton(AuthRepoImp(getIt.get<ApiService>()));
  getIt.registerSingleton<OrdersSocketService>(OrdersSocketService());
  getIt.registerLazySingleton<OrdersCubit>(
    () => OrdersCubit(getIt.get<HomeRepoImp>()),
  );
  getIt.registerSingleton(
    HomeRepoImp(getIt.get<ApiService>(), getIt.get<OrdersSocketService>()),
  );
  getIt.registerSingleton(ProfileRepoImp(getIt.get<ApiService>()));
  getIt.registerSingleton(AddDishRepoImp(getIt.get<ApiService>()));
  getIt.registerSingleton<EditDishRepo>(
    EditDishRepoImp(getIt.get<ApiService>()),
  );
}

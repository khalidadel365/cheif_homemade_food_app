import 'package:cheif_homemade_food/features/home/data/repos/home_repo_imp.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo_imp.dart';

import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton(AuthRepoImp());
  getIt.registerSingleton(HomeRepoImp());
}

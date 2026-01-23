import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import 'bloc_observer.dart';
import 'constants.dart';
import 'core/utilities/api_service.dart';
import 'core/utilities/app_router.dart';
import 'core/utilities/service_locator.dart';
import 'features/auth/data/repos/auth_repo_imp.dart';
import 'features/auth/presentation/manager/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  getIt.get<ApiService>().init();
  runApp(const CheifHomeMadeFood());
}

class CheifHomeMadeFood extends StatelessWidget {

  const CheifHomeMadeFood({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImp>()),
      child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: kBackGroundColor,
            fontFamily: kFontFamily,
          )
      ),
    );
  }
}

import 'package:cheif_homemade_food/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utilities/app_router.dart';
import '../../../../core/utilities/functions/show_snack_bar.dart';
import '../../../../core/utilities/loading_view.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_states.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          print(state.loginModel.token);
          showSnackBar(
              context: context,
              message: 'Login Successfully'
              , color: Colors.green);
          //GoRouter.of(context).go(AppRouter.kMainView);
        }
        if(state is LoginErrorState){
          print(state.error);
          showSnackBar(
              context: context,
              message: state.error
              , color: Colors.red);
        }
      },
      builder: (context, state) {
        return Stack(children: [
          const Scaffold(
            body: SafeArea(child: LoginViewBody()),
          ),
          if (state is LoginLoadingState) const LoadingView()
        ]);
      },
    );
  }
}

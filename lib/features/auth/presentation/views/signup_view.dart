import 'package:cheif_homemade_food/features/auth/presentation/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utilities/app_router.dart';
import '../../../../core/utilities/functions/show_snack_bar.dart';
import '../../../../core/utilities/loading_view.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_states.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          showSnackBar(
              context: context,
              message: "Account created successfully!",
              color: Colors.green);
          Future.delayed(Duration(seconds: 1), () {
            GoRouter.of(context).go(AppRouter.kLoginView);
          });
        } else if (state is SignupErrorState) {
          showSnackBar(
              context: context, message: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            const Scaffold(
              body: SafeArea(child: SignUpViewBody()),
            ),
            if (state is SignupLoadingState)
              const LoadingView(),
          ],
        );
      },
    );
  }
}



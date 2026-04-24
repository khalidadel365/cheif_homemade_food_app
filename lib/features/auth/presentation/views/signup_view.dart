import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/features/auth/presentation/views/widgets/signup_step.dart';
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
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final int _totalPages = 2;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          showSnackBar(context: context, message: "Account created successfully!", color: Colors.green);
          Future.delayed(Duration(seconds: 1), () { GoRouter.of(context).go(AppRouter.kLoginView); });
        } else if (state is SignupErrorState) {
          showSnackBar(context: context, message: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildStepper(),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) => setState(() => _currentIndex = index),
                        children: [
                          SignUpViewBody(pageController: _pageController),
                          const Center(child: Text("Next Step View Body")),
                        ],
                      ),
                    ),
                  ],
                ),
                if (state is SignupLoadingState) const LoadingView(),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalPages, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: _currentIndex >= index ? kPrimaryColor : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }),
      ),
    );
  }
}



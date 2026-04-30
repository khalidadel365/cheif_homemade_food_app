import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            height: 1.0,
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 7),
        title: Text('My Menu', style: Styles.textStyle23),
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined,size: 26,),
          ),
        ],
      ),
      body: HomeViewBody(),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 27,
        ),
      ),
    );
  }
}

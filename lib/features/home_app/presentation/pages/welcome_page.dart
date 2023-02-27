import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/features/home_app/presentation/pages/home_app.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/utils/Navigation/Navigation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: InkWell(
              onTap: () {
                Navigation.push(
                    const HomeApp());
              },
              child: Container(
                  height: AppDimension.screenHeight(context) / 10,
                  width: AppDimension.screenWidth(context) / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          colors: [Colors.cyan, Colors.blue])),
                  child: Center(
                      child: Text(
                        "start_here".tr(),
                        style: AppTheme.headline3
                            .copyWith(color: AppColors.white),
                      )))),
        ));
  }
}

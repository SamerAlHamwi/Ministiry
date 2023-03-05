import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child:LoadingBouncingGrid.square(
          borderColor:AppColors.primaryColor,
          backgroundColor: AppColors.primaryColor,
          size: 80.0,
        )
    );

      /*const CupertinoActivityIndicator(

    );*/
  }
}

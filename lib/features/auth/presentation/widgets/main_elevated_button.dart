import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class MainElevatedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final double? height;
  final double? width;
  final bool? isDark;
  final bool? withPadding;

  const MainElevatedButton(
      {Key? key,
      this.onTap,
      this.text,
      this.height,
      this.width,
      this.isDark = false,
      this.withPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: 55,
            width: double.infinity,
            padding: withPadding == true ? const EdgeInsets.all(16) : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: isDark!
                        ? [AppColors.primaryColor, AppColors.blueColor]
                        : [Colors.cyan, Colors.blue])),
            child: Center(
                child: Text(
              text!,
              style: AppTheme.headline3.copyWith(color: AppColors.white),
              textAlign: TextAlign.center,
            ))));
  }
}

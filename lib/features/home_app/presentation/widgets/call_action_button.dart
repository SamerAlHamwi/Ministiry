import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_theme.dart';

class CallActionsButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? buttonText;
  final Color? textColor;
  final Color? buttonColor;

  const CallActionsButton(
      {Key? key, this.onTap, this.textColor, this.buttonText, this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: AppDimension.screenWidth(context)*2/10,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(buttonText ?? "",
                style: AppTheme.bodyText1.copyWith(color: textColor)),
          )),
    );
  }
}

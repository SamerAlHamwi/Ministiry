import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'base_error_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NotFoundErrorWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? message;


  const NotFoundErrorWidget({Key? key, this.onTap, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BaseErrorWidget(
      onTap: onTap,
      title: message,
      subtitle: 'Tap to retry'.tr(),
      icon: SvgPicture.asset(
        AppAssets.error,
      //  width: 20.0.w,
        height: 12.0.h,
      )

    );

  }
}

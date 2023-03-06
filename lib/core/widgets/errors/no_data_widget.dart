import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_assets.dart';
import 'base_error_widget.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  const NoDataWidget({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
      onTap: null,
      title: message ?? 'no_data'.tr(),
      subtitle: '',
      icon: Image.asset(
        AppAssets.searchHeart,
        height: 12.0.h,
        // color: AppColors.primary,
      ),
    );
  }
}

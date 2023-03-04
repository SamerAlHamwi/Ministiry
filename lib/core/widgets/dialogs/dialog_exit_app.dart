import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_theme.dart';

class DialogExitApp extends StatefulWidget {
  final String? title;
  final String? content;
  final VoidCallback? onPressedYes;
  final VoidCallback? onPressedNo;

  const DialogExitApp(
      {Key? key, this.title, this.content, this.onPressedYes, this.onPressedNo})
      : super(key: key);

  @override
  _DialogExitAppState createState() => _DialogExitAppState();
}

class _DialogExitAppState extends State<DialogExitApp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        widget.title!,
      ),
      content: Text(
        widget.content!,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width /4,
                 height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  child: Text('yes'.tr(),
                      style:
                          AppTheme.bodyText2.copyWith(color: AppColors.white)),
                  onPressed: widget.onPressedYes,
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.shade600,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: widget.onPressedNo,
                  child: Text('no'.tr(),
                      style:
                          AppTheme.bodyText2.copyWith(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

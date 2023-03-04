import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../constants/app_theme.dart';
import 'frequently_used_function/frequenty_funtions.dart';
class LogoutPopupMenuButton extends StatelessWidget {
  final Color? color;
  const LogoutPopupMenuButton({Key? key,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(icon: Icon(Icons.adaptive.more,color: color,),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: "logout",
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "logout".tr(),
                style: AppTheme.bodyText1,
              ),
            ),
          )
        ];
      },
      onSelected: (String value) {
        if (value == "logout") {
          FrequentlyFunction.showLogoutConfirmDialog(
              context, LoginPage());
        }
      },
    );
  }
}

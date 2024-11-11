

import 'package:flutter/material.dart';
import 'package:ministry_minister_app/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:ministry_minister_app/core/utils/Navigation/Navigation.dart';
import 'package:ministry_minister_app/features/app_update/presentation/app_update_screen.dart';
import '../../../core/boilerplate/get_model/cubits/get_model_cubit.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utils/shared_preferences/SharedPreferencesHelper.dart';
import '../../../core/widgets/image_widgets/custom_image.dart';
import '../../auth/presentation/pages/login_page.dart';
import '../../auth/repository/authentication_repository.dart';
import '../../home_app/presentation/pages/home_app.dart';
import '../data/app_update_model.dart';
import '../data/app_update_request.dart';


class CheckUpdateScreen extends StatefulWidget {
  const CheckUpdateScreen({super.key});

  @override
  State<CheckUpdateScreen> createState() => _CheckUpdateScreenState();
}

class _CheckUpdateScreenState extends State<CheckUpdateScreen> {


  late GetModelCubit updateCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.background), fit: BoxFit.fill)),
        child: GetModel<AppUpdateModel>(
            onSuccess: (AppUpdateModel model){
              if(model.appFilePath != null && model.appFilePath!.isNotEmpty){
                Navigation.push(UpdateScreen(appUpdateModel: model,));
              }else{
                Navigation.push(AppSharedPreferences.hasAccessToken ? const HomeApp() : const LoginPage(),);
              }
            },
            modelBuilder: (AppUpdateModel model) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: AppDimension.screenHeight(context) / 4,
                    child: CustomImage.circular(
                      image: AppAssets.disabledLogo,
                      radius: 200,
                      isNetworkImage: false,
                      svg: false,
                    ),
                  ),
                ],
              );
            },
            repositoryCallBack: (data) => AuthenticationRepository.checkAppUpdate(),
            onCubitCreated: (GetModelCubit cubit) {
              updateCubit = cubit;
            },
            loading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: AppDimension.screenHeight(context) / 4,
                  child: CustomImage.circular(
                    image: AppAssets.disabledLogo,
                    radius: 200,
                    isNetworkImage: false,
                    svg: false,
                  ),
                ),
              ],
            ),
            withRefresh: false,
        ),
      ),
    );
  }

}



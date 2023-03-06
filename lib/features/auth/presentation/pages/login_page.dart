import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/core/animations/fade_animation.dart';
import 'package:ministry_minister_app/core/constants/app_dimension.dart';
import 'package:ministry_minister_app/features/home_app/presentation/pages/home_app.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/utils/shared_preferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/image_widgets/custom_image.dart';
import '../../data/login_request_model.dart';
import '../../data/login_response_model.dart';
import '../../repository/authentication_repository.dart';
import '../widgets/main_elevated_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? password;

  TextEditingController? userName;

  final LoginRequestModel _loginRequestModel = LoginRequestModel(
      rememberClient: true, password: "", userNameOrEmailAddress: "");

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    password = TextEditingController(text: _loginRequestModel.password);
    userName =
        TextEditingController(text: _loginRequestModel.userNameOrEmailAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(
                right: 16,
                left: 16,
                top: AppDimension.screenHeight(context) / 5),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.background), fit: BoxFit.fill)),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...[
                                FadeAnimation(
                                  fadeDirection: FadeDirection.right,
                                  delay: 2,
                                  child: CustomTextField(
                                    controller: userName,
                                    hintText: 'email_address'.tr(),
                                    validator: (value) {
                                      Validator.nameValidate(value!, context);
                                    },
                                    onChanged: (userName) {
                                      _loginRequestModel
                                          .userNameOrEmailAddress = userName;
                                    },
                                    textInputAction: TextInputAction.next,
                                    inputDecoration: AppTheme.inputDecoration
                                        .copyWith(
                                            prefixIcon: Icon(Icons.person,
                                                color: AppColors.grey)),
                                    keyboardType: TextInputType.text,
                                    required: true,
                                    general: false,
                                  ),
                                ),
                                FadeAnimation(
                                  fadeDirection: FadeDirection.right,
                                  delay: 2,
                                  child: CustomTextField(
                                    controller: password,
                                    hintText: 'password'.tr(),
                                    required: true,
                                    obscureText: true,
                                    validator: (value) {
                                      Validator.passwordValidate(value!, context);
                                    },
                                    inputDecoration: AppTheme.inputDecoration
                                        .copyWith(
                                            prefixIcon: Icon(Icons.key_rounded,
                                                color: AppColors.grey)),
                                    onChanged: (email) {
                                      _loginRequestModel.password = email;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    general: false,
                                  ),
                                ),
                                // ElevatedButton(onPressed: (){}, child:Text("تسجيل الدخول")),
                    FadeAnimation(
                        fadeDirection: FadeDirection.right,
                        delay: 2,
                        child:_buildLoginButton(context))
                              ].expand((element) => [
                                    element,
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ]),
                            ]),
                      ]),
                ))));
  }

  CreateModelCubit? loginCubit;

  _buildLoginButton(context) {
    return CreateModel<LoginResponseModel>(
        onSuccess: (LoginResponseModel model) {
          AppSharedPreferences.accessToken = model.accessToken!;
          Navigation.pushReplacement(HomeApp());
        },
        repositoryCallBack: (data) =>
            AuthenticationRepository.authenticateLogIn(data),
        onCubitCreated: (CreateModelCubit cubit) {
          loginCubit = cubit;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 64),
          child: MainElevatedButton(
            onTap: () {
              var valid = _formKey.currentState!.validate();
              if (valid && loginCubit != null) {
                FocusScope.of(_formKey.currentState!.context).unfocus();
                loginCubit!.createModel(_loginRequestModel);
              } else {
                return;
              }
            },
            text: "login".tr(),
          ),
        ));
  }
}

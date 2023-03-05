import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/core_models/empty_model.dart';
import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../../core/constants/app_theme.dart';
import '../../domain/repositories/call_reception_repo.dart';
import '../pages/home_app.dart';

class CancelCallPopUp extends StatelessWidget {
  final int? callId;

  CancelCallPopUp({Key? key, this.callId}) : super(key: key);
  CreateModelCubit? CancleCallRequestCubit;

  @override
  Widget build(BuildContext context) {
    return CreateModel<EmptyModel>(
        onSuccess: (EmptyModel model) {},
        repositoryCallBack: (data) => CallReceptionRepo.CancleCallRequest(data),
        onCubitCreated: (CreateModelCubit cubit) {
          CancleCallRequestCubit = cubit;
        },
        child: PopupMenuButton(
            icon: Icon(
              Icons.adaptive.more,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "cancel",
                  child: ListTile(
                    leading: const Icon(Icons.cancel_outlined),
                    title: Text(
                      "cancel".tr(),
                      style: AppTheme.bodyText1,
                    ),
                  ),
                )
              ];
            },
            onSelected: (String value) {
              if (value == "cancel") {
                CancleCallRequestCubit!.createModel(callId).then((value) {
                  HomeApp.updateWaitingCallList();
                });
              }
            }));
  }
}

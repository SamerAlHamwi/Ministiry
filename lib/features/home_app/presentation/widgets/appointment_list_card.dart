import 'package:flutter/foundation.dart';
import 'dart:ui' as UI;

import '../../../../core/api/core_models/empty_model.dart';
import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/boilerplate/create_model/widgets/create_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/jitsi_video_meeting/video_meeting_service.dart';
import '../../../../core/utils/service_locator/service_locator.dart';
import '../../data/calls_list_response.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../../domain/repositories/call_reception_repo.dart';
import 'call_action_button.dart';

class CallListCard extends StatelessWidget {
  final Call call;
  final bool active;

  CreateModelCubit? deleteCubit;

  CallListCard({super.key, this.active = true, required this.call});

  @override
  Widget build(BuildContext context) {
    return _buildCallCard(
      context,
    );
  }

  Widget _buildCallCard(context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: call!.callStatus == 1
              ? AppColors.primarySwatch[100]
              : call!.callStatus == 2
              ? AppColors.green
              : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.date_range, color: AppColors.primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    "${"date".tr()} : ",
                    style: AppTheme.headline3
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(call.creationTime!.split("T")[0].toString(),
                      style:
                      AppTheme.headline3.copyWith(color: AppColors.offWhite,fontWeight: FontWeight.w700))
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text("${"time".tr()} : ",
                      style: AppTheme.headline3
                          .copyWith(color: AppColors.primaryColor)),
                  Text(DateTime.tryParse('${call!.creationTime!}Z')!.toLocal().toString().split('.')[0].toString().split(" ")[1].toString(),
                      style: AppTheme.headline3.copyWith(
                          color: AppColors.offWhite,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          // Date and time container
          _getButtons(),

          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " ${"Order Number".tr()}: ${call.orderNumber}",
                style: AppTheme.bodyText1,
              ),

              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        _getStatusColor(_getStatus(call.callStatus!))),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    _getStatus(call.callStatus!),
                    style: AppTheme.bodyText1,
                  ),
                ],
              ),

            ],
          ),


        ],
      )
    );
  }

  String getDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  _getStatusColor(String status) {
    if (status == "Waiting".tr()) {
      return Colors.yellow;
    } else if (status == "Treated".tr()) {
      return Colors.green;
    } else if (status == "Canceled".tr()) {
      return Colors.redAccent;
    }
    else if (status == "Active".tr()) {
      return Colors.green;
    }
  }

  String _getStatus(int status) {
    if (status == 1) {
      return "Waiting".tr();
    } else if (status == 2) {
      return "Treated".tr();
    } else if (status == 3) {
      return "Canceled".tr();
    }
    else if (status == 4) {
      return "Active".tr();
    }
    return "Active".tr();
  }

  CreateModelCubit? CancleCallRequestCubit;

  _buildCancelButton() {
    return CreateModel<EmptyModel>(
        onSuccess: (EmptyModel model) {},
        repositoryCallBack: (data) => CallReceptionRepo.CancleCallRequest(data),
        onCubitCreated: (CreateModelCubit cubit) {
          CancleCallRequestCubit = cubit;
        },
        child: CallActionsButton(
            buttonText: "cancel".tr(),
            buttonColor: AppColors.lightBlueColor,
            textColor: AppColors.white,
            onTap: () {
              CancleCallRequestCubit!.createModel(call!.id!);
            }));
  }

  Widget _getButtons() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CallActionsButton(
              onTap: () {
                if (active) {
                  VideoMeetingService.startMeeting(
                    roomText: call.room!,
                    serverUrl: call.link!,
                    meetingId: call.id!,
                  );
                }
              },
              buttonColor: AppColors.primaryColor,
              buttonText: 'join_call'.tr(),
              textColor: Colors.white,
            ),
            _buildCancelButton(),
          ],
        );
  }
}

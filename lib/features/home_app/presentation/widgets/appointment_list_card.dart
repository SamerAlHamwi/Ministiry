import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/jitsi_video_meeting/video_meeting_service.dart';
import '../../data/calls_list_response.dart';
import '../../domain/repositories/appointment_repository.dart';
import 'call_action_button.dart';
import 'cancel_call_popUp.dart';

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
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${call.orderNumber}",
                  style: AppTheme.headline3,
                ),
                CancelCallPopUp(callId: call.id)
              ],
            ),
            Row(
              children: [
                const Icon(Icons.date_range, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  "${"date".tr()} : ",
                  style: AppTheme.bodyText1
                      .copyWith(color: AppColors.primaryColor),
                ),
                Text(call.creationTime!.split("T")[0].toString(),
                    style: AppTheme.bodyText1)
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
                    style: AppTheme.bodyText1
                        .copyWith(color: AppColors.primaryColor)),
                Text(
                    DateTime.tryParse('${call!.creationTime!}Z')!
                        .toLocal()
                        .toString()
                        .split('.')[0]
                        .toString()
                        .split(" ")[1]
                        .toString(),
                    style: AppTheme.bodyText1)
              ],
            ),
            _getButtons(),
          ],
        ));
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
    } else if (status == "Active".tr()) {
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
    } else if (status == 4) {
      return "Active".tr();
    }
    return "Active".tr();
  }

  /* CreateModelCubit? CancleCallRequestCubit;

  _buildCancelButton() {
    return CreateModel<EmptyModel>(
        onSuccess: (EmptyModel model) {},
        repositoryCallBack: (data) => CallReceptionRepo.CancleCallRequest(data),
        onCubitCreated: (CreateModelCubit cubit) {
          CancleCallRequestCubit = cubit;
        },
        child: CallActionsButton(
            buttonText: "cancel".tr(),
            buttonColor: Colors.red[400],
            textColor: AppColors.white,
            onTap: () {
              CancleCallRequestCubit!.createModel(call!.id!).then((value) {
                HomeApp.updateWaitingCallList();
              });
            }));
  }*/

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CallActionsButton(
          onTap: () async {
            if (active) {
              await CallsRepository.joinCall(id: call.id!);
              VideoMeetingService.startMeeting(
                roomText: call.room!,
                serverUrl: call.link!,
                meetingId: call.id!,
              );
            }
          },
          buttonColor: Colors.green[500],
          buttonText: 'join_call'.tr(),
          textColor: Colors.white,
        ),
        // _buildCancelButton(),
      ],
    );
  }
}

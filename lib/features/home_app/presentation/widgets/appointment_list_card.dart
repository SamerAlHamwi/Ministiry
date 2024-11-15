import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:ministry_minister_app/core/constants/app_assets.dart';
import 'package:ministry_minister_app/core/widgets/image_widgets/custom_image.dart';
import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/video_meeting/video_meeting_service.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and time
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getStatusColor(_getStatus(call.callStatus!))),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${call.orderNumber}",
                    style: AppTheme.headline3,
                  )
                ],
              ),
              Row(
                children: [
                  CancelCallPopUp(callId: call.id)
                ],
              ),
            ]),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  call!.callRequesterName != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              Text(
                                "اسم العميل : ",
                                style: AppTheme.headline3
                                    .copyWith(color: AppColors.blueColor),
                              ),
                              Text(
                                call!.callRequesterName ?? "",
                                style: AppTheme.headline3,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CustomImage.rectangle(
                        image: AppAssets.dateIcon,
                        isNetworkImage: false,
                        svg: false,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 8),
                      Text("${"date".tr()} : ", style: AppTheme.bodyText1),
                      Text(call.creationTime!.split("T")[0].toString(),
                          style: AppTheme.bodyText1)
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      CustomImage.rectangle(
                        image: AppAssets.timeIcon,
                        isNetworkImage: false,
                        svg: false,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 8),
                      Text("${"time".tr()} : ", style: AppTheme.bodyText1),
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
                ]),
              ],
            ),
            _getButtons()
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
      return Colors.deepOrange;
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

  CreateModelCubit? joinCubit;


  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CreateModel(
          onSuccess: (Call model) {
            VideoMeetingService.startMeeting(
              call: model,
            );
          },
          repositoryCallBack: (data) => CallsRepository.joinCall(id: call.id!),
          onCubitCreated: (CreateModelCubit cubit) {
            joinCubit = cubit;
          },
          child: CallActionsButton(
            onTap: () async {
              if (active) {
                joinCubit!.createModel({});
              }
            },
            buttonColor: active ? Colors.green[500] : AppColors.grey,
            buttonText: 'join_call'.tr(),
            textColor: Colors.white,
          ),
        ),
        // _buildCancelButton(),
      ],
    );
  }
}

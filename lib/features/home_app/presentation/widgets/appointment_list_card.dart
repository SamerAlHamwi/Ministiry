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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.grey),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Healthcare center
                  Row(
                    children: [
                      // Healthcare center name and address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Doctor Photo

                          const SizedBox(
                            width: 10,
                          ),

                          // Doctor name and center name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Doctor name
                              Text(
                                call.screen?.name! ?? '',
                                style: AppTheme.headline3,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              // Date and time container
              _getDateContainer(),

              const SizedBox(
                height: 10,
              ),

              // Patient  name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " ${"Patient Name".tr()}: ${call.screen?.name!}",
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
          ),
        ],
      ),
    );
  }

  String getDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  _getStatusColor(String status) {
    if (status == "Pending".tr()) {
      return Colors.yellow;
    } else if (status == "Declined".tr()) {
      return Colors.redAccent;
    } else if (status == "Approved".tr()) {
      return Colors.green;
    }
  }

  String _getStatus(int status) {
    if (status == 1) {
      return "Pending".tr();
    } else if (status == 2) {
      return "Approved".tr();
    } else if (status == 3) {
      return "Declined".tr();
    }
    return "Pending".tr();
  }

  Widget _getDateContainer() {
    return call.callStatus == 1
        ? InkWell(
            onTap: () {
              if (active) {
                VideoMeetingService.startMeeting(
                  roomText: call.room!,
                  serverUrl: call.link!,
                  meetingId: call.id!,
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.buttonTextColor,
                  borderRadius: BorderRadius.circular(15)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.videocam_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('Join Call'.tr(),
                    style: AppTheme.headline3.copyWith(color: Colors.white))
              ]),
            ),
          )
        : InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  // color: call.healthCareCenter!.name == null
                  //     ? AppColors.buttonTextColor
                  //     : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.date_range_rounded,
                          color: AppColors.white),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        call.screenJoinedDate!,
                        // getDate(call.screenJoinedDate!),
                        style:
                            AppTheme.subtitle1.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),

                  // Time Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: AppColors.white),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat("hh:mm a")
                            .format(DateTime.parse(call.screenJoinedDate!)),
                        style:
                            AppTheme.subtitle1.copyWith(color: AppColors.white),
                        textDirection: UI.TextDirection.ltr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

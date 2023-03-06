import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';

import '../../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../widgets/appointment_list_card.dart';

class AppointmentsHistoryPage extends StatelessWidget {
  const AppointmentsHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          title: Text('calls_history'.tr(),
              style: const TextStyle(color: AppColors.primaryColor)),
        ),
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            AppAssets.disableBackground,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
          Image.asset(
            AppAssets.background,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
          _getBodyWidget(context)
        ]));
  }

  Container _getBodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: PaginationList<Call>(
              repositoryCallBack: (data) =>
                  CallsRepository.getCalls(requestData: data, isOldCalls: true),
              listBuilder: (List<Call> list) {
                return _getUpcomingAppointments(list);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _getUpcomingAppointments(List<Call> list) {
    return ListView(
        children: List.generate(
            list.length,
            (index) => CallListCard(
                  key: GlobalKey(),
                  call: list[index],
                )));
  }
}

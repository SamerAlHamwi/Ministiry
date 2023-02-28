import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ministry_minister_app/core/api/data_source/remote_data_source.dart';
import 'package:ministry_minister_app/features/auth/presentation/pages/login_page.dart';
import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';

import '../../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../../core/constants/Keys.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../widgets/appointment_list_card.dart';

class AppointmentsHistoryPage extends StatelessWidget {
  const AppointmentsHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          title: Text('calls_history'.tr(), style: const TextStyle(color: AppColors.primaryColor)),
        ),
        body: _getBodyWidget(context));
  }

  Container _getBodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.background), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width/ 1.1,
              child: PaginationList<Call>(
                repositoryCallBack: (data) => CallsRepository.getCalls(
                  requestData: data,
                ),
                listBuilder: (List<Call> list) {
                  List<Call> oldCalls = list.where((call) => call.callStatus == 2).toList();
                  return _getUpcomingAppointments(oldCalls);
                },
              ),
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
              call: list[index],
            )));
  }
}


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ministry_minister_app/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';

import '../../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../../core/constants/Keys.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/logout_popUp_menu_button.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../widgets/appointment_list_card.dart';
import 'appointment_history_page.dart';

class HomeApp extends StatefulWidget {
  static PaginationCubit? waitingCallCubit;
  static ScrollController _scrollController = ScrollController();

  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();

  static void updateWaitingCallList() {
    if (HomeApp.waitingCallCubit != null) {
      HomeApp.waitingCallCubit!.getList();
      _scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Keys.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const LogoutPopupMenuButton(),
          actions: [
            IconButton(
                icon: const Icon(Icons.history, color: AppColors.primaryColor),
                onPressed: () {
                  Navigation.push(const AppointmentsHistoryPage());
                }),
          ],
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          title: Text('Calls'.tr(),
              style: const TextStyle(color: AppColors.primaryColor)),
        ),
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            AppAssets.disableBackground,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low
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
      /*  decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.background,), fit: BoxFit.fill)),*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: PaginationList<Call>(
                onCubitCreated: (cubit) {
                  HomeApp.waitingCallCubit = cubit;
                },
                repositoryCallBack: (data) => CallsRepository.getCalls(
                  requestData: data,
                ),
                listBuilder: (List<Call> list) {
                  return _getUpcomingAppointments(list);
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
        controller: HomeApp._scrollController,
        children: List.generate(
            list.length,
            (index) => CallListCard(
                  key: GlobalKey(),
                  call: list[index],
                )));
  }
}

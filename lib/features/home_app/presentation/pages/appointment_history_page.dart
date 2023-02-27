import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../../core/utils/service_locator/service_locator.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../widgets/appointment_list_card.dart';

class AppointmentHistoryPage extends StatefulWidget {
  const AppointmentHistoryPage({super.key});

  @override
  State<AppointmentHistoryPage> createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(),
       // body: _getBodyWidget()
    );
  }
/*
  Container _getBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:
                // Upcoming list of appointments
                PaginationList<Appointment>(
              repositoryCallBack: (data) =>
                  AppointmentRepository.getAppointments(
                requestData: data,
                IsBeforeCurrentDate: true,
              ),
              onCubitCreated: (cubit) {
                ServiceLocator.setAppointments(cubit);
              },
              listBuilder: (List<Appointment> list) =>
                  _getUpcomingAppointments(list),
            ),
          ),
        ],
      ),
    );
  }

  ListView _getUpcomingAppointments(List<Appointment> list) {
    return ListView(
        children: List.generate(
            list.length,
            (index) => AppointmentListCard(
                  active: false,
                  appointment: list[index],
                )));
  }*/
}

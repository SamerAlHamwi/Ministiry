import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ministry_minister_app/features/home_app/data/calls_list_response.dart';

import '../../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../../core/constants/Keys.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../widgets/appointment_list_card.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: Keys.scaffoldKey,
        body: _getBodyWidget());
  }

  Container _getBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PaginationList<Call>(
              repositoryCallBack: (data) => CallsRepository.getCalls(
                requestData: data,
              ),
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
                  call: list[index],
                )));
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String specality;
  final VoidCallback onTap;
  final String image;

  const AppointmentCard(
      {super.key,
      required this.name,
      required this.specality,
      required this.onTap,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.white,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.grey,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Image.asset(
                          image,
                          height: 10.h,
                          width: 10.h,
                          fit: BoxFit.fill,
                        ),
                      ),
//                  SizedBox(
//                    width: 5.w,
//                  ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              textAlign: TextAlign.justify,
                              style: AppTheme.subtitle1.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold)),
                          Text(specality,
                              textAlign: TextAlign.start,
                              style: AppTheme.subtitle1.copyWith(
                                color: AppColors.black,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PopupMenuButton(
                        child: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Delete".tr()),
                              ),
                            ],
                        onSelected: (selection) {
                          switch (selection) {
                            case 1:
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text("are you sure?".tr()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("No".tr(),
                                              style: const TextStyle(
                                                  color: AppColors.red)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes".tr(),
                                              style: const TextStyle(
                                                  color: AppColors.red)),
                                        ),
                                      ],
                                    );
                                  });
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                height: 8.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor.shade300,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        AppAssets.calenderIcon,
                        height: 6.w,
                        width: 6.w,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("الاثنين 26-1-2020"),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      AppAssets.clockHomePage,
                      height: 6.w,
                      width: 6.w,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("11:00 - 12:00 صباحا"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),

              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     TextButton(
              //       style: TextButton.styleFrom(
              //         // primary: Colors.white,
              //         backgroundColor: AppColors.primary,
              //         //side: BorderSide(color: Colors.deepOrange, width: 1),
              //         elevation: 0,
              //         minimumSize: Size(42.5.w, 11.w),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         shadowColor: Colors.red,
              //       ),
              //       onPressed: () {},
              //       child: Text('تعديل',
              //           style: AppTheme.headline5
              //               .copyWith(color: AppColors.pureWhite)),
              //     ),
              //     OutlinedButton(
              //       onPressed: () {},
              //       child: Text("إلغاء",
              //           style: AppTheme.headline5
              //               .copyWith(color: AppColors.gray1)),
              //       style: TextButton.styleFrom(
              //         // primary: Colors.white,
              //         //backgroundColor: AppColors.primary,
              //         //side: BorderSide(color: Colors.deepOrange, width: 1),
              //         elevation: 0,
              //         minimumSize: Size(42.5.w, 11.w),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         shadowColor: Colors.red,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 4.h,
              // ),
              Container(
                height: 0.8.h,
                color: const Color(0xFFE5E5E5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import '../custom_button.dart';
// import '../constants/appcolors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants/Keys.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// class MyBottomSheet{
//
//   static showConfirmBottomSheet({context , String? text ,   ValueChanged<bool>? onClicked , Widget? form  }) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 10,
//         enableDrag: true,
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext bc) {
//           return Padding(
//             padding: EdgeInsets.only(bottom: 3.0.h , top:  3.0.h , right: 3.0.w , left: 3.0.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.only(bottom: 3.0.h),
//                   child: Text(text ?? "" ,),
//                 ),
//                 form??Container(),
//
//                 Container(
//                   child: new Wrap(
//                     direction: Axis.horizontal,
//                     children: <Widget>[
//                       CustomButton(
//                         text: 'Confirm'.tr(),
//                         onPressed: () {
//                           onClicked!(true);
//                           Navigator.pop(context);
//                           // cubit.finishTask(task);
//                         },
//                       ),
//                       CustomButton(
//                         color: AppColors.grey,
//                         text: 'Cancel'.tr(),
//                         onPressed: () {
//                           onClicked!(false);
//                           Navigator.pop(context);
//                           // cubit.finishTask(task);
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           );
//         }
//         );
//   }
//
//   static showBottomSheet({ Widget? child  })async  {
//     return await showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 10,
//         // enableDrag: true,
//         // isScrollControlled: true,
//         context: Keys.navigatorKey.currentContext!,
//         useRootNavigator: true,
//         builder: (BuildContext bc) {
//
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               Divider(
//                 indent: 45.w,
//                  endIndent: 45.w,
//                  thickness: 3,
//                 color: Colors.grey,
//               ),
//               Expanded(
//                 child: Container(
//                  // height: 50.h,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 2.0.h , top:  2.0.h , right: 3.0.w , left: 3.0.w),
//                     child: child??Container(),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//     );
//   }
// }
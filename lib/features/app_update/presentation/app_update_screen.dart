

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ministry_minister_app/core/constants/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/widgets/image_widgets/custom_image.dart';
import '../../auth/presentation/widgets/main_elevated_button.dart';
import 'package:app_installer/app_installer.dart';

import '../data/app_update_model.dart';



class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.appUpdateModel});

  final AppUpdateModel appUpdateModel;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {


  double _downloadProgress = 0.0;
  bool _isDownloading = false;
  CancelToken _cancelToken = CancelToken();
  final String _apkUrl = "https://api.keyfinder.net/Uploads/Apks/keyFinder_3.0.1.apk";

  Future<bool> requestPermissions() async {
    if (!(await Permission.requestInstallPackages.request().isGranted)) {
      return false;
    }
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    } else if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  void _startDownload() async {

    if(await requestPermissions()){

      setState(() {
        _isDownloading = true;
        _downloadProgress = 0.0;
      });

      final directory = await getExternalStorageDirectory();
      print(directory);
      final filePath = '${directory!.path}/app-latest.apk';

      try {
        await Dio().download(
          widget.appUpdateModel.appFilePath ?? '',
          filePath,
          onReceiveProgress: (received, total) {
            setState(() {
              _downloadProgress = received / total;
            });
          },
          cancelToken: _cancelToken,
        );

        AppInstaller.installApk(filePath);

      } catch (e) {
        print(e);
      }

      setState(() {
        _isDownloading = false;
      });
    }
  }

  void _cancelDownload() {
    if (_isDownloading) {
      _cancelToken.cancel();
      _cancelToken = CancelToken();
      setState(() {
        _isDownloading = false;
        _downloadProgress = 0.0;
      });
    }else{
      exit(0);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
            right: 16,
            left: 16,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.background), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: AppDimension.screenHeight(context) / 4,
              child: CustomImage.circular(
                image: AppAssets.disabledLogo,
                radius: 200,
                isNetworkImage: false,
                svg: false,
              ),
            ),
            Text(
              "A new update is available",
              style: AppTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isDownloading
                ? Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.blueColor,
                    inactiveTrackColor: AppColors.black,
                    thumbColor: AppColors.blueColor,
                  ),
                  child: Slider(
                    value: _downloadProgress,
                    min: 0,
                    max: 1,
                    divisions: 100,
                    activeColor: AppColors.blueColor,
                    inactiveColor: AppColors.black,
                    thumbColor: AppColors.blueColor,
                    label: "${(_downloadProgress * 100).toStringAsFixed(0)}%",
                    onChanged: null,
                  ),
                ),
                Text(
                  "Downloading: ${(_downloadProgress * 100).toStringAsFixed(0)}%",
                  style: AppTheme.headline3,
                ),

                const SizedBox(height: 20),
                MainElevatedButton(
                  onTap: _cancelDownload,
                  text: "Cancel",
                ),
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 40,
                  child: MainElevatedButton(
                    onTap: _startDownload,
                    text: "Update",
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: MainElevatedButton(
                    onTap: () => exit(0),
                    text: "Cancel",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}



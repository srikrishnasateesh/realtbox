import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/core/utils/data_utils.dart';

class DocumentsTab extends StatefulWidget {
  final String projectName;
  final List<String> brochureImages;
  final List<String> floorPlanImages;
  final List<String> buildingPlanImages;
  const DocumentsTab({
    super.key,
    required this.projectName,
    required this.brochureImages,
    required this.floorPlanImages,
    required this.buildingPlanImages,
  });

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab>
    with TickerProviderStateMixin {
  static const platform = MethodChannel('in.axivise.realtbox/download');
  bool _isDownloading = false;
  String _progress = "";

  Future<void> _downloadFiles(List<String> files, String name) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PermissionStatus status;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.mediaLibrary.request();
        if (status.isDenied) {
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      try {
        // Start all downloads concurrently
        List<Future<void>> downloadTasks = [];

        for (var file in files) {
          String url = file;
          // Create download task for each file
          String filename =
              "${widget.projectName}-$name-${DateTime.now().toString()}.${getFileExtension(url)}";
          downloadTasks.add(_downloadFile(url, filename));
        }

        // Wait for all downloads to finish
        await Future.wait(downloadTasks);

        debugPrint("All downloads completed.");
      } catch (e) {
        debugPrint("Error downloading files: $e");
      }
    } else if (status.isDenied) {
      debugPrint("Permission denied");
    } else if (status.isPermanentlyDenied) {
      debugPrint("Permission denied permanently");
      openAppSettings();
    }
  }

  Future<void> _downloadFile(String url, String filename) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PermissionStatus status;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        status = await Permission.mediaLibrary.request();
        if (status.isDenied) {
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.storage.request();
      }
    } else /* if (Platform.isIOS) */ {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      try {
        setState(() {
          _isDownloading = true;
        });

        // Get the directory to save the file
        Directory?
            appDocDir = //await getTemporaryDirectory();//getExternalStoragePublicDirectory();
            await getApplicationDocumentsDirectory();
        String savePath = "${appDocDir.path}/$filename";

        // Download the file
        Dio dio = Dio();
        await dio.download(url, savePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = "${(received / total * 100).toStringAsFixed(0)}%";
            });
          }
        });

        if (Platform.isAndroid) {
          final result = await platform.invokeMethod('saveFile', {
            'filePath': savePath,
            'fileName': filename,
          });
        }

        setState(() {
          _isDownloading = false;
          _progress = "Download completed";
        });
        debugPrint("Download completed: $savePath");
      } catch (e) {
        setState(() {
          _isDownloading = false;
          _progress = "Download failed";
        });
        debugPrint("Download failed: $e");
      }
    } else if (status.isDenied) {
      debugPrint("Permission denied");
    } else if (status.isPermanentlyDenied) {
      debugPrint("Permission denied permanently");
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 210,
              child: _isDownloading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        widget.brochureImages.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: 210,
                                    child: FilledButton.icon(
                                      onPressed: () => {
                                        _downloadFiles(
                                            widget.brochureImages, "Broucher")
                                      },
                                      icon: const Icon(Icons.download_sharp),
                                      label: const Text('Brochure'),
                                      iconAlignment: IconAlignment.end,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        foregroundColor: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              )
                            : Container(),
                        widget.buildingPlanImages.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: 210,
                                    child: FilledButton.icon(
                                      onPressed: () => {
                                        _downloadFiles(
                                            widget.buildingPlanImages,
                                            "BuildingPlan")
                                      },
                                      icon: const Icon(Icons.download_sharp),
                                      label: const Text('Building Plan'),
                                      iconAlignment: IconAlignment.end,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        foregroundColor: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              )
                            : Container(),
                        widget.floorPlanImages.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: 210,
                                    child: FilledButton.icon(
                                      onPressed: () => {
                                        _downloadFiles(
                                            widget.floorPlanImages, "Floor")
                                      },
                                      icon: const Icon(Icons.download_sharp),
                                      label: const Text('Floor Plan'),
                                      iconAlignment: IconAlignment.end,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        foregroundColor: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              )
                            : Container(),
                        widget.brochureImages.isEmpty &&
                                widget.buildingPlanImages.isEmpty &&
                                widget.floorPlanImages.isNotEmpty
                            ? const Center(child: Text('No data found'))
                            : Container()
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

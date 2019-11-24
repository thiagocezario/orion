import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadProvider extends ChangeNotifier {
  bool _opend = false;

  get opend => _opend;

  Future init() async {
    if (_opend) {
      return;
    }
    _opend = true;

   // test();
  }

  void open() {
    _opend = true;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.jpeg');
  }

  Future test() async {

    // String path = await _localPath;

    // FlutterDownloader.initialize().then((a) {
    //   final taskId = FlutterDownloader.enqueue(
    //     url:
    //         'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     savedDir: path,
    //     fileName: 'orion_teste.png',
    //     showNotification:
    //         true, // show download progress in status bar (for Android)
    //     openFileFromNotification:
    //         true, // click on notification to open downloaded file (for Android)
    //   );

    //   print('Loucuragem total..');
    //   return a;
    // });
  }
}

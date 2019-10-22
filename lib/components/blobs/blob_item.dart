import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orion/model/blob.dart';
import 'package:path_provider/path_provider.dart';

class BlobItem extends StatelessWidget {
  final Blob blob;

  BlobItem({Key key, this.blob}) : super(key: key);

  void removeFile() {
    print('Remove file logic');
    // reload post ?
  }

  IconButton removeButton() {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: removeFile,
    );
  }

  Future download() async {
    print('Download file logic');

    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;

    var _downloadData = List<int>();
    var fileSave = new File('$tempPath/logo_pipe.png');

    HttpClient client = new HttpClient();
    client
        .getUrl(Uri.parse(
            "https://fluttermaster.com/wp-content/uploads/2018/08/fluttermaster.com-logo-web-header.png"))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((d) => _downloadData.addAll(d), onDone: () {
        print(_downloadData);
        fileSave.writeAsBytes(_downloadData);
        print('ok');
        print(fileSave.readAsString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.attachment),
        title: Text(blob.filename),
        trailing: removeButton(),
        onTap: download,
      ),
    );
  }
}

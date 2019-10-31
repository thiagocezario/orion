import 'package:flutter/material.dart';
import 'package:orion/model/blob.dart';

class BlobItem extends StatefulWidget {
  final Blob blob;

  BlobItem({Key key, this.blob}) : super(key: key);

  @override
  _BlobItemState createState() => _BlobItemState(blob);
}

class _BlobItemState extends State<BlobItem> {
  Blob blob;

  _BlobItemState(this.blob);

  void removeFile() {
    setState(() {
      blob.toRemove = true;
    });
  }

  void keepFile() {
    setState(() {
      blob.toRemove = false;
    });
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

  IconButton keepButton() {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.black,
      ),
      onPressed: keepFile,
    );
  }

  IconButton editButton() {
    return blob.toRemove ? keepButton() : removeButton();
  }

  Text decoredFilename() {
    return Text(
      blob.filename,
      style: TextStyle(color: blob.toRemove ? Colors.grey : Colors.black),
    );
  }

  Future download() async {
    print('Download file logic');

    // Directory tempDir = await getApplicationDocumentsDirectory();
    // String tempPath = tempDir.path;

    // var _downloadData = List<int>();
    // var fileSave = new File('$tempPath/logo_pipe.png');

    // HttpClient client = new HttpClient();
    // client
    //     .getUrl(Uri.parse(
    //         "https://fluttermaster.com/wp-content/uploads/2018/08/fluttermaster.com-logo-web-header.png"))
    //     .then((HttpClientRequest request) {
    //   return request.close();
    // }).then((HttpClientResponse response) {
    //   response.listen((d) => _downloadData.addAll(d), onDone: () {
    //     print(_downloadData);
    //     fileSave.writeAsBytes(_downloadData);
    //     print('ok');
    //     print(fileSave.readAsString());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.attachment),
        title: decoredFilename(),
        trailing: editButton(),
        onTap: download,
      ),
    );
  }
}

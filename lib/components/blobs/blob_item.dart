import 'package:flutter/material.dart';
import 'package:orion/api/base.dart';
import 'package:orion/model/blob.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Uri uri = Base.collectionPath('/api/blobs/${blob.id}/download');
    launch(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.attachment),
      title: decoredFilename(),
      trailing: editButton(),
      onTap: download,
    );
  }
}

class BlobItemPreview extends StatelessWidget {
  final Blob blob;

  BlobItemPreview(this.blob);
  Future download() async {
    Uri uri = Base.collectionPath('/api/blobs/${blob.id}/download');
    launch(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.attachment),
      title: Text(
        blob.filename,
        style: TextStyle(color: blob.toRemove ? Colors.grey : Colors.black),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.file_download,
          color: Colors.lightBlueAccent,
        ),
        onPressed: () => download(),
      ),
    );
  }
}

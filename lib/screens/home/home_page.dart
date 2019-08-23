import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text('Home Page'),
          leading: IconButton(
            icon: BackButton(),
            onPressed: () => runApp(Orion()),
          ),
        ),
      ),
    );
  }
}

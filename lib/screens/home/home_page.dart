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
      body: getGroupCell(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people, color: Color.fromARGB(255, 0, 0, 0)),
              title: Text('Grupos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 0, 0)),
              title: Text('Perfil')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
              title: Text('Buscar'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
      ),
    )
    );
  }
}

Widget getGroupCell() {
  return Container(
      padding: EdgeInsets.all(15.0),
      height: 140.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all()
          ),
      ));
}

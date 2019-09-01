import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/login/login_components.dart';

class NewAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createAccountButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Criar",
            textAlign: TextAlign.center,
            style: getTextStyle()
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orion',
        home: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              title: Text('Nova conta', style: TextStyle(color: Colors.black),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          getLogo(),
                          getTextField('Email'),
                          SizedBox(height: 5.0),
                          getPasswordField('Senha'),
                          SizedBox(
                            height: 5.0,
                          ),
                          getPasswordField('Confirmar senha'),
                          SizedBox(
                            height: 25.0,
                          ),
                          createAccountButton,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

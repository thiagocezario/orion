import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _autoCompleteKey = GlobalKey<AutoCompleteTextFieldState<String>>();
  final _autoCompleteKey1 = GlobalKey<AutoCompleteTextFieldState<String>>();
  final _autoCompleteKey2 = GlobalKey<AutoCompleteTextFieldState<String>>();
  final _institutionFieldController = TextEditingController();
  final _courseFieldController = TextEditingController();
  final _classFieldController = TextEditingController();
  AutoCompleteTextField institutionField;
  AutoCompleteTextField courseField;
  AutoCompleteTextField classField;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xff8893f2),
          appBar: getAppBar(context),
          body: ListView(
            children: <Widget>[
              _buildForm(context),
            ],
          )),
    );
  }

  Form _buildForm(BuildContext context) {
    institutionField = AutoCompleteTextField<String>(
      clearOnSubmit: false,
      key: _autoCompleteKey,
      controller: _institutionFieldController,
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: suggestionList(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Instituição',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0))
          ],
        );
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          institutionField.textField.controller.text = item;
        });
      },
    );

    courseField = AutoCompleteTextField<String>(
      clearOnSubmit: false,
      key: _autoCompleteKey1,
      controller: _courseFieldController,
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: suggestionList(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Curso',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0))
          ],
        );
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          courseField.textField.controller.text = item;
        });
      },
    );

    classField = AutoCompleteTextField<String>(
      clearOnSubmit: false,
      key: _autoCompleteKey2,
      controller: _classFieldController,
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      suggestionsAmount: 4,
      suggestions: suggestionList(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Classe',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      style: getTextStyle(),
      itemBuilder: (context, item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0))
          ],
        );
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          classField.textField.controller.text = item;
        });
      },
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getTitleMessage('Novo grupo', Colors.black),
            SizedBox(
              height: 50.0,
            ),
            institutionField,
            SizedBox(
              height: 10.0,
            ),
            courseField,
            SizedBox(
              height: 10.0,
            ),
            classField,
            SizedBox(
              height: 25.0,
            ),
            // getMaterialButton(context, _autoCompleteKey, 'Criar', () {}),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              // color: Color(0xff606fe1),
              color: Color(0xff192376),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                elevation: 50.0,
                onPressed: () {
                  // if (_formKey.currentState.validate()) {
                  // action();
                  // }
                },
                child: Text('Criar',
                    textAlign: TextAlign.center,
                    style: getTextStyle().copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> suggestionList() {
    List<String> suggestionlist = List();

    suggestionlist.add("UFPR");
    suggestionlist.add("Universidade Federal do Paraná");
    suggestionlist.add("UFSC");
    suggestionlist.add("Universidade Federal de Santa Catarina");
    suggestionlist.add("UFPG");
    suggestionlist.add("Universidade Federal de Ponta Grossa");
    suggestionlist.add("UEL");
    suggestionlist.add("Universidade Estadual de Londrina");
    suggestionlist.add("Panelinha");
    suggestionlist.add("Test");
    suggestionlist.add("aeHOOOOO");

    return suggestionlist;
  }
}

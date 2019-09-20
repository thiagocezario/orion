import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/search_group_page.dart';

import 'new_group_page.dart';

class NewGroupFilter extends StatefulWidget {
  final List<Group> groups;

  NewGroupFilter({Key key, this.groups}) : super(key: key);
  @override
  _NewGroupFilterState createState() => _NewGroupFilterState(groups);
}

class _NewGroupFilterState extends State<NewGroupFilter> {
  List<Group> groups = List();

  _NewGroupFilterState(this.groups);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8893f2),
          elevation: 0.0,
          title: Text(
            'Grupos',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return Material(
              child: InkWell(
                onTap: () {},
                child: Card(
                  elevation: 5.0,
                  margin: EdgeInsets.all(7.5),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, top: 10.0, bottom: 10.0),
                          child: Text(
                            groups[index].name.toUpperCase(),
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13.0, bottom: 3.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.place),
                              Text(groups[index].institutionName)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.person),
                              Text(groups[index].members.length.toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: _buildFloatingButton(context));
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 15.0,
          backgroundColor: Colors.green,
          onPressed: () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Color(0xff8893f2),
                            elevation: 0.0,
                            title: Text(
                              'Novo Grupo',
                              style: TextStyle(color: Colors.black),
                            ),
                            centerTitle: true,
                            leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          body: NewGroupPage(),
                        )),
              );
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/api/client.dart';
import 'package:orion/components/commom_items/commom_items.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/model/user.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
import 'package:orion/provider/my_events_provider.dart';
import 'package:orion/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

class MyGroups extends StatefulWidget {
  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  Widget headerList(BuildContext context, List<Group> recommendations) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0
            ? const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 3.0, bottom: 30.0)
            : const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 3.0, bottom: 30.0);

        return new Padding(
          padding: padding,
          child: new InkWell(
            onTap: () {},
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black.withAlpha(70),
                      offset: const Offset(3.0, 2.0),
                      blurRadius: 3)
                ],
              ),
              width: 200.0,
              child: new Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        onPressed: () {
                          var singleton = Singleton();
                          Client.subscribe(
                                  singleton.jwtToken, recommendations[index].id)
                              .then((response) {
                            if (response.statusCode == 201) {
                              Provider.of<MyGroupsProvider>(context)
                                  .refreshMyGroups();
                              Provider.of<GroupRecomendationsProvider>(context)
                                  .refreshMyRecomendations();
                              Provider.of<MyEventsProvider>(context)
                                  .fetchEvents();
                            }
                          });
                        },
                        child: Text('Ingressar',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  new Align(
                    alignment: Alignment.bottomCenter,
                    child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: new Radius.circular(10.0),
                                bottomRight: new Radius.circular(10.0))),
                        height: 30.0,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              '${recommendations[index].name}',
                              style: new TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: recommendations.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, myGroupsState, _) =>
          Consumer<GroupRecomendationsProvider>(
        builder: (context, recommendations, _) => Container(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  // new Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: new Padding(
                  //       padding: new EdgeInsets.only(left: 8.0),
                  //       child: new Text(
                  //         'Recomendaçoes',
                  //         style: new TextStyle(color: Colors.black),
                  //       )),
                  // ),
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    child: headerList(
                        context, recommendations.groupRecomendations),
                  ),
                  Expanded(
                    child: GroupCards()
                        .getGroupCards(context, myGroupsState.myGroups),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

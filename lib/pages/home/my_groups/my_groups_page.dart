import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orion/components/groups/group_cards.dart';
import 'package:orion/model/group.dart';
import 'package:orion/provider/group_recomendations_provider.dart';
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

        return Padding(
          padding: padding,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(70),
                      offset: const Offset(3.0, 2.0),
                      blurRadius: 3)
                ],
              ),
              width: 200.0,
              child: Stack(
                children: <Widget>[
                  // Container(
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.only(left: 30, right: 30),
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular(30.0),
                  //     color: Colors.blue,
                  //     child: MaterialButton(
                  //       minWidth: MediaQuery.of(context).size.width,
                  //       padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  //       onPressed: () {
                  //         var singleton = Singleton();
                  //         Client.subscribe(
                  //                 singleton.jwtToken, recommendations[index].id)
                  //             .then((response) {
                  //           if (response.statusCode == 201) {
                  //             Provider.of<MyGroupsProvider>(context)
                  //                 .refreshMyGroups();
                  //             Provider.of<GroupRecomendationsProvider>(context)
                  //                 .refreshMyRecomendations();
                  //             Provider.of<MyEventsProvider>(context)
                  //                 .fetchEvents();
                  //           }
                  //         });
                  //       },
                  //       child: Text('Ingressar',
                  //           textAlign: TextAlign.center,
                  //           style: textStyle.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold)),
                  //     ),
                  //   ),
                  // ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  '${recommendations[index].name}'.toUpperCase(),
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                            )
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.place),
                            Expanded(
                              child: Text(
                                '${recommendations[index].institution.name}',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.people),
                            Text(
                              '${recommendations[index].metadata.subscriptions}',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ))
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
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 8),
                          child: Text(
                            'Recomendações',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

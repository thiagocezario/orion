import 'package:flutter/material.dart';
import 'package:orion/model/global.dart';
import 'package:orion/model/group.dart';
import 'package:orion/pages/group/group_preview_page.dart';
import 'package:orion/provider/preview_provider.dart';
import 'package:provider/provider.dart';

class GroupRecommendations extends StatelessWidget {
  final List<Group> recommendations;

  GroupRecommendations(this.recommendations);

  EdgeInsets paddingByIndex(int index) {
    return index == 0
        ? const EdgeInsets.only(left: 20.0, right: 5.0, top: 3.0, bottom: 0.0)
        : const EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0, bottom: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    void showRecomendation(Group group) {
      Provider.of<PreviewProvider>(context).refreshAll(group);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GroupPreviewPage(group)));
    }

    Widget recomendationItem(Group group, int index) {
      return Padding(
        padding: paddingByIndex(index),
        child: InkWell(
          onTap: () {
            showRecomendation(group);
          },
          child: Container(
            width: (MediaQuery.of(context).size.width / 10) * 8.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: themeColor),
            ),
            child: ListTile(
              title: Text(recommendations[index].name),
              subtitle:
                  Text('${recommendations[index].colleagues} colegas em comum'),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return recomendationItem(recommendations[index], index);
      },
      scrollDirection: Axis.horizontal,
      itemCount: recommendations.length,
    );
  }
}

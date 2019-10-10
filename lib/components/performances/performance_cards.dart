import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/model/performance.dart';

class PerformanceCards {
  ListView getPerformanceCards(
      BuildContext context, List<Performance> performances) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: performances.length,
      itemBuilder: (context, index) {
        return _buildPerformanceCard(performances[index]);
      },
    );
  }

  Widget _buildPerformanceCard(Performance performance) {
    IconButton performanceActions(Performance performance) {
      return IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      );
    }

    ListTile card = ListTile(
      leading: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Text("${performance.percentage}%"),
      ),
      title: Text(performance.description),
      subtitle: Text(
          "${performance.value.toString()} / ${performance.maxValue.toString()}"),
      trailing: performanceActions(performance),
      isThreeLine: true,
    );

    return Material(
      child: InkWell(
        onTap: () {},
        child: card,
      ),
    );
  }
}

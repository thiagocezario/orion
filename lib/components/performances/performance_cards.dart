import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/components/performances/performance_item.dart';
import 'package:orion/model/performance.dart';

class PerformanceCards {
  ListView getPerformanceCards(
      BuildContext context, List<Performance> performances) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: performances.length,
      itemBuilder: (context, index) {
        return PerformanceItem(performance: performances[index]);
      },
    );
  }
}

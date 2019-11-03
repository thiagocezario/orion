import 'package:flutter/material.dart';
import 'package:orion/components/groups/subscription_icon.dart';
import 'package:orion/model/subscriptions.dart';

class SubscriptionsPreview extends StatelessWidget {
  final List<Subscription> subscriptions;

  SubscriptionsPreview(this.subscriptions);

  @override
  Widget build(BuildContext context) {
    int subCount = subscriptions.length > 10 ? 10 : subscriptions.length;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            leading: SubscriptionIcon(subscriptions[index]),
            title: Text(
              subscriptions[index].student.name,
            ),
            subtitle: Text(
              subscriptions[index].student.email,
            ),
          );
        },
        childCount: subCount,
      ),
    );
  }
}

// SliverList(
//   delegate: SliverChildBuilderDelegate(
//     (context, index) {
//       if (!subscriptionsState.subscriptions[index].banned &&
//           subscriptionsState.subscriptions[index].active) {
//         return ListTile(
//             leading: SubscriptionIcon(
//                 subscriptionsState.subscriptions[index]),
//             title: Text(
//                 subscriptionsState.subscriptions[index].student.name),
//             subtitle: Text(subscriptionsState
//                 .subscriptions[index].student.email),
//             trailing: subscriptionAction(
//                 subscriptionsState.subscriptions[index]));
//       }

//       return SizedBox(
//         height: 0,
//         width: 0,
//       );
//     },
//     childCount: subscriptionsState.subscriptions.length,
//   ),
// ),
// SliverList(
//   delegate: SliverChildBuilderDelegate(
//     (context, index) {
//       if (subscriptionsState.subscriptions[index].banned) {
//         return ListTile(
//             leading: SubscriptionIcon(
//                 subscriptionsState.subscriptions[index]),
//             title: Text(
//               subscriptionsState.subscriptions[index].student.name,
//               style: TextStyle(
//                 color: Colors.red,
//               ),
//             ),
//             subtitle: Text(
//               subscriptionsState.subscriptions[index].student.email,
//               style: TextStyle(
//                 color: Colors.red,
//               ),
//             ),
//             trailing: subscriptionAction(
//                 subscriptionsState.subscriptions[index]));
//       }

//       return SizedBox(
//         height: 0,
//         width: 0,
//       );
//     },
//     childCount: subscriptionsState.subscriptions.length,
//   ),
// ),

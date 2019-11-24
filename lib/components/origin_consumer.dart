import 'package:flutter/material.dart';
import 'package:orion/actions/open_invite.dart';
import 'package:orion/actions/open_reset.dart';
import 'package:orion/provider/download_provider.dart';
import 'package:orion/provider/origin_provider.dart';
import 'package:provider/provider.dart';

class OriginConsumer extends StatelessWidget {
  final Widget child;

  OriginConsumer({this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<OriginProvider>(builder: (context, originProvider, _) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => afterBuild(context, originProvider));

      return Consumer<DownloadProvider>(builder: (context, downloadProvider, _) {
        // downloadProvider.init();

        return child;
      });
    });
  }

  void afterBuild(BuildContext context, OriginProvider provider) {
    if (!provider.opend) {
      Provider.of<OriginProvider>(context).open();
      openInvite(context, provider.uri);
      openReset(context, provider.uri);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;

  const WiredashApp({
    Key? key,
    required this.navigatorKey,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      navigatorKey: navigatorKey,
      child: child,
      projectId: 'moviecinemasample-s57wh1k',
      secret: 'Jits-XQTpdF3OpQOOhUQi22fnQA--T33',
      options: WiredashOptionsData(
        showDebugFloatingEntryPoint: false,
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
        dividerColor: AppColor.vulcan
      ),
    );
  }
}

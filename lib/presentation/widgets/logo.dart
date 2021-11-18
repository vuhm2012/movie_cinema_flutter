import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/app_logo.png',
      height: height.h,
    );
  }
}

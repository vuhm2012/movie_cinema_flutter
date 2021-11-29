import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: isEnabled ? MaterialStateProperty.all(AppColor.royalBlue) : MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
        )),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_4.h,
        ),
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

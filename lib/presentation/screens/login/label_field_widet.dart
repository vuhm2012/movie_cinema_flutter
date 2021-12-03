import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';

class LabelFieldWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;

  const LabelFieldWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
  }) : super(key: key);

  @override
  State<LabelFieldWidget> createState() => _LabelFieldWidgetState();
}

class _LabelFieldWidgetState extends State<LabelFieldWidget> {

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            maxLines: 1,
            focusNode: _focusNode,
            obscureText: widget.isPasswordField,
            controller: widget.controller,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.label,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

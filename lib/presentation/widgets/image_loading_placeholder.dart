import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/presentation/screens/loading/loading_circle.dart';

class ImageLoadingPlaceHolder extends StatelessWidget {
  final double loadingSize;

  const ImageLoadingPlaceHolder({
    Key? key,
    required this.loadingSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: LoadingCircle(
          size: loadingSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/flutter_drag_scale.dart';

class PictureWidget extends StatelessWidget {
  final String source;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      width: 400,
      child: Center(
        child: DragScaleContainer(
          doubleTapStillScale: true,
          child: Image(
            image: NetworkImage(source),
          ),
        ),
      ),
    );
  }

  PictureWidget(this.source);
}

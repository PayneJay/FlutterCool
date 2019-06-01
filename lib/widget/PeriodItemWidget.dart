import 'package:flutter/material.dart';
import 'package:myapp/models/magChild.dart';

class PeriodItemWidget extends StatelessWidget {
  final MagChild _magChild;

  const PeriodItemWidget(this._magChild);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              children: <Widget>[
                Text(
                  _magChild == null ? '' : _magChild.title,
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
        Divider(
          color: Colors.black12,
        )
      ],
    );
  }
}

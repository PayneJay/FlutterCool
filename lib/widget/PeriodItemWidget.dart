import 'package:flutter/material.dart';
import 'package:flutter_cool/models/magChild.dart';
import 'package:flutter_cool/business/discover/mag/PeriodDetailScreen.dart';
import 'package:flutter_cool/business/discover/mag/PeriodDetailScreen.dart';

class PeriodItemWidget extends StatelessWidget {
  final MagChild _magChild;

  final BuildContext _context;

  const PeriodItemWidget(this._magChild, this._context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _magChild == null ? '' : _magChild.title,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      _magChild == null ? '' : _formatDate(_magChild.time),
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    )
                  ],
                )),
            Divider(
              color: Colors.black12,
            )
          ],
        ),
        onTap: () {
          _onPeriodItemClick();
        });
  }

  void _onPeriodItemClick() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
      return PeriodDetailScreen(_magChild);
    }));
  }

  String _formatDate(num time) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    if (dateTime.difference(DateTime.now()).inDays == 0) {
      return '今日更新';
    }
    var month = dateTime.month;
    var day = dateTime.day;
    return '$month月$day日';
  }
}

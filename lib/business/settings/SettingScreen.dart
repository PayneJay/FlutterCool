import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: SingleChildScrollView(
        child: Column(
          children: itemLabels.map((item) => _buildColumn(item)).toList(),
        ),
        padding: EdgeInsets.only(top: 16.0),
      ),
    );
  }

  Column _buildColumn(String item) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onTap: () {})
              ],
            )),
        Divider(
          color: Colors.black12,
        ),
      ],
    );
  }
}

const itemLabels = ["设置1", "设置2", "设置3", "设置4", "设置5"];

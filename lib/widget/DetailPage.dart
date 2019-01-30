import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RatingPage.dart';
import 'package:myapp/share/ShareApp.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text('Oeschinen Lake Campground',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                new Text('Kandersteg, Switzweland',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ))
              ],
            ),
          ),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41'),
        ],
      ),
    );

    void _call() async {
      const url = 'tel:+1 555 010 999';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void _viewRating() {
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new RatingPage();
      }));
    }

    void _share() {
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new ShareApp();
      }));
    }

    Column buildButtonColumn(IconData icon, String label, int index) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new IconButton(
            icon: new Icon(icon, color: color),
            onPressed:
                (index == 1) ? _call : (index == 2) ? _viewRating : _share,
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(label,
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                )),
          )
        ],
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL', 1),
          buildButtonColumn(Icons.near_me, 'ROUTE', 2),
          buildButtonColumn(Icons.share, 'SHARE', 3)
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true),
    );

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Detail'),
            centerTitle: true,
          ),
          body: new ListView(
            children: <Widget>[
              new Image.network(
                'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?dpr=1&auto=format&fit=crop&w=767&h=583&q=80&cs=tinysrgb&crop=',
                height: 240.0,
                width: 600.0,
                fit: BoxFit.cover,
              ),
              titleSection,
              buttonSection,
              textSection,
            ],
          )),
    );
  }
}

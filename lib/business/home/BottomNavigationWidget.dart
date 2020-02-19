import 'package:flutter/material.dart';
import 'package:cool/business/settings/SettingScreen.dart';
import 'HomeScreen.dart';
import 'package:cool/business/profile/ProfileScreen.dart';
import 'package:cool/business/theme/ThemeScreen.dart';
import 'package:cool/business/site/SiteScreen.dart';
import 'package:cool/business/discover/DiscoverScreen.dart';
import 'package:cool/business/search/SearchScreen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> pages = List<Widget>();
  OverlayEntry menuOverlayEntry;

  @override
  void initState() {
    pages
      ..add(HomeScreen())
      ..add(SiteScreen())
      ..add(ThemeScreen())
      ..add(DiscoverScreen())
      ..add(ProfileScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _getBottomNavigationBarItem(0),
          _getBottomNavigationBarItem(1),
          _getBottomNavigationBarItem(2),
          _getBottomNavigationBarItem(3),
          _getBottomNavigationBarItem(4),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar buildAppBar() {
    switch (_currentIndex) {
      case 0:
      case 1:
      case 2:
        return AppBar(
            elevation: _currentIndex == 0 ? 0 : 5,
            title: Text(titles[_currentIndex]),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _goSearch(),
              ),
              _showPopupMenu()
            ]);
      case 3:
        return null;
      case 4:
        return AppBar(
            elevation: 5,
            title: Text(titles[_currentIndex]),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _goSetting(),
              )
            ]);
    }
    return AppBar();
  }

  void _goSearch() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchScreen();
    }));
  }

  void _goSetting() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen();
    }));
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          navIcons[index],
          color: _bottomNavigationColor,
        ),
        title: Text(
          titles[index],
          style: TextStyle(color: _bottomNavigationColor),
        ));
  }

  PopupMenuButton _showPopupMenu() {
    return PopupMenuButton<String>(
        //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
        onSelected: (String value) {
          setState(() {
            print('PopupMenuButton value : $value');
          });
        },
        offset: Offset(0, kToolbarHeight),
        //这是弹出菜单的建立
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              _getPopupMenuItem(0),
              _getPopupMenuItem(1),
              _getPopupMenuItem(2),
              _getPopupMenuItem(3),
              _getPopupMenuItem(4),
            ]);
  }

  PopupMenuItem<String> _getPopupMenuItem(int index) {
    var content = menuNames[index];
    return PopupMenuItem(
      child: Text(menuNames[index]),
      value: '这是 $content',
    );
  }
}

const _bottomNavigationColor = Colors.blueAccent;
const titles = ["文章", "站点", "主题", "发现", "我的"];
const menuNames = ["仅中文", "仅英文", "中英混合", "推荐设置", "一周拾遗"];
const navIcons = [
  Icons.home,
  Icons.cast_connected,
  Icons.assessment,
  Icons.find_in_page,
  Icons.account_box
];

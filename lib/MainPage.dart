import 'package:flutter/material.dart';
import 'package:homecontrol/tab/DeviceTab.dart';
import 'package:homecontrol/tab/MonitorTab.dart';
import 'package:homecontrol/tab/MineTab.dart';


class MainPage extends StatefulWidget {
  var title;
  MainPage(this.title);
  @override
  State<StatefulWidget> createState() {
    return MainPageState(title);
  }
}

class MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['监控', '设备', '我的'];
  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  var title;

  MainPageState(this.title);

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [
        getTabImage('images/camera_off.png'),
        getTabImage('images/camera_on.png')
      ],
      [
        getTabImage('images/device_off.png'),
        getTabImage('images/device_on.png')
      ],
      [getTabImage('images/mine_off.png'), getTabImage('images/mine_on.png')]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new HomePage(),
      new FindPage(),
      new MinePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //初始化数据
    initData();

    return Scaffold(
        body: _pageList[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {

    });
  }
}

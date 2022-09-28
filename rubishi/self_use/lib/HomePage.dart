import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:self_use/nuclearAcid/NuclearAcidPage.dart';
import 'package:self_use/test/TestPage.dart';

import 'erciyuan/ErciyuanPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => HomePageState();

}

class HomePageState extends State<HomePage> with TickerProviderStateMixin{

  List<Widget> pages = [];
  int _currentIndex = 0;
  TabController _tabController;
  double width = 360 / 3;
  @override
  void initState() {
    super.initState();
    pages
      ..add(Live2dPage())
      ..add(NuclearAcidPage())
      ..add(TestPage());
    _tabController = TabController(
      length: pages.length,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
      if (_tabController.index != _tabController.previousIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = 360 / 3;
    var homePage = SizedBox(
      height: 70,
      width: width,
      child: IconButton(
        splashRadius: 1,
        icon: _currentIndex == 0
            ? SvgPicture.asset(
          'assets/svg_pics/home.svg',
        )
            : SvgPicture.asset(
          'assets/svg_pics/home.svg',
          color: Colors.grey,
        ),
        color: Colors.white,
        onPressed: () => _tabController.animateTo(0),
      ),
    );

    var feedbackPage = SizedBox(
      height: 70,
      width: width,
      child: IconButton(
        splashRadius: 1,
        icon: _currentIndex == 1
            ? SvgPicture.asset(
          'assets/svg_pics/lake.svg',
        )
            : SvgPicture.asset(
          'assets/svg_pics/lake_grey.svg',
        ),
        color: Colors.white,
        onPressed: () {
          if (_currentIndex == 1) {
          } else
            _tabController.animateTo(1);
        },
      ),
    );

    var selfPage = SizedBox(
      height: 70,
      width: width,
      child: IconButton(
        splashRadius: 1,
        icon: _currentIndex == 2
            ? SvgPicture.asset(
          'assets/svg_pics/my.svg',
        )
            : SvgPicture.asset(
          'assets/svg_pics/my.svg',
          color: Colors.grey,
        ),
        color: Colors.white,
        onPressed: () => _tabController.animateTo(2),
      ),
    );
    var bottomNavigationBar = Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: -1, blurRadius: 2)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),

      /// 适配iOS底部安全区
      child: SafeArea(
        child: Row(children: <Widget>[homePage, feedbackPage, selfPage]),
      ),
    );
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: bottomNavigationBar,
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
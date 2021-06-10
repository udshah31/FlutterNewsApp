import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepal_sansar/widgets/drawer.dart';
import 'tabPage/coronavirus_page.dart';
import 'tabPage/economy_page.dart';
import 'tabPage/english_page.dart';
import 'tabPage/entertainment_page.dart';
import 'tabPage/health_page.dart';
import 'tabPage/homeNews_page.dart';
import 'tabPage/international_page.dart';
import 'tabPage/news_page.dart';
import 'tabPage/newspaper_page.dart';
import 'tabPage/politics_page.dart';
import 'tabPage/prawas_page.dart';
import 'tabPage/sports_page.dart';
import 'tabPage/technology_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 13, vsync: this);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nepal Sansar",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 2.0,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          automaticIndicatorColorAdjustment: true,
          indicator: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.white70,
          unselectedLabelStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          tabs: [
            Tab(text: "गृह पृष्ठ"),
            Tab(text: "समाचार"),
            Tab(text: "राजनीति"),
            Tab(text: "अन्तराष्ट्रिय"),
            Tab(text: "अर्थ"),
            Tab(text: "प्रवास"),
            Tab(text: "खेलकुद"),
            Tab(text: "मनोरञ्जन"),
            Tab(text: "सूचना प्रबिधि"),
            Tab(text: "यौन/स्वास्थ्य"),
            Tab(text: "पत्रपत्रिकाबाट"),
            Tab(text: "कोरोना भाइरस"),
            Tab(text: "English"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: TabBarView(
            controller: _tabController,
            children: [
              HomeNewsPage(),
              NewsPage(),
              PoliticsPage(),
              InternationalPage(),
              EconomyPage(),
              PrawasPage(),
              SportsPage(),
              EntertainmentPage(),
              TechnologyPage(),
              HealthPage(),
              NewspaperPage(),
              CoronaVirusPage(),
              EnglishPage()
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

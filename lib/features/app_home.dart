import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:smarty/features/profile/presentation/views/photoScreen.dart';

import 'devices/presentation/views/device_home.dart';
import 'home/presentation/views/home.dart';
import 'routine/presentation/views/routine_home.dart';
import 'stats/presentation/views/stats_home.dart';
import 'voice/presentation/views/voice_home.dart';

class Dashboard extends StatefulWidget {
  final int initialTab;
  const Dashboard({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _children =  [
    HomeScreen(),
    DevicesScreen(),
    VoiceHomeScreen(),
     InfoScreen(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _children.length, vsync: this);
    _tabController.index = widget.initialTab;
    super.initState();
  }

  void onTabTapped(int index) {
    _tabController.index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
    GFDrawer(
    child: ListView(
    padding: EdgeInsets.zero,
      children: <Widget>[
        GFDrawerHeader(
          currentAccountPicture: GFAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg"),
          ),
          otherAccountsPictures: <Widget>[
            Image(
              image: NetworkImage("https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg"),
              fit: BoxFit.cover,
            ),
            GFAvatar(
              child: Text("ab"),
            )
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('user name'),
              Text('user@userid.com'),
            ],
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: null,
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: null,
        ),
      ],
    ),
    ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: _children,
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _tabController.index,
        unselectedFontSize: 14,
        elevation: 2.0,
        // selectedItemColor: ShuttlersColors.shuttlersGreen,
        // selectedIconTheme: ShuttlersThemes.iconThemeData,
        // selectedLabelStyle: TextStyle(
        //   fontWeight: FontWeight.w600,
        //   letterSpacing: 0.0,
        //   fontSize: 12.0,
        // ),
        // unselectedLabelStyle: TextStyle(
        //   letterSpacing: 0.0,
        //   fontSize: 12.0,
        // ),
        // backgroundColor: Colors.white,
        enableFeedback: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,color: Colors.grey,),
              activeIcon: Icon(Icons.home_outlined),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone_iphone_rounded,color: Colors.grey,),
              activeIcon: Icon(Icons.phone_iphone_rounded),
              label: "Device"),
          BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_voice_outlined,color: Colors.grey,),
              activeIcon: Icon(Icons.keyboard_voice_outlined),
              label: "Voice"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.grey,),
              activeIcon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:taksibuddy/constants.dart';
import 'package:taksibuddy/home/sidebarx.dart';
import 'package:taksibuddy/login/login_page.dart';
import 'package:taksibuddy/service/auth.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../chat_page/chat_page.dart';
import '../chat_page/messages.dart';
import '../profile_screen/profile_screen.dart';
import 'home_body.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final _controller = SidebarXController(selectedIndex: 0, extended: true);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 00.0,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          backgroundColor: primaryColor.withOpacity(0.6),
          elevation: 0,
          title: Text(widget.title),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
          ),
        ),
        body: PersistentTabView(
          context,
          screens: screens(), 
          items: items(),
          navBarStyle: NavBarStyle.style1,
        ),
        drawer: ExampleSidebarX(controller: _controller));
  }

  ListView listViewDrawer(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Text('Taksi Buddy'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Log Out'),
          onTap: () {
            // _auth.signOut().then((value) {
            //   return Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => LoginPage()));
            // });
            // Navigator.pop(context);
            _auth.handleSignOut().then((value) {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 350, left: 250),
          child: FloatingActionButton(
              heroTag: "btn7",
              backgroundColor: Colors.red.shade400,
              child: Icon(Icons.close),
              onPressed: (() {
                Navigator.of(context).pop();
              })),
        )
      ],
    );
  }

  List<Widget> screens() {
    return [
      ChatPage(
        email: emailinfo.toString(),
        arguments: null,
      ),
      HomeBody(),
      ProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> items() {
    return [
      PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.black,
          icon: const Icon(CupertinoIcons.chat_bubble),
          title: 'Sohbet',
          activeColorPrimary: Colors.yellow.shade600),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.black,
          icon: const Icon(CupertinoIcons.map),
          title: 'Ana Sayfa',
          activeColorPrimary: Colors.yellow.shade600),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: Colors.black,
          icon: const Icon(CupertinoIcons.profile_circled),
          title: 'Profil',
          activeColorPrimary: Colors.yellow.shade600),
    ];
  }
}

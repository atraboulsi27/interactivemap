import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'map.dart';
import 'mystories.dart';
import 'gallery.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  int currentIndex = 0;
  Map<int, Widget> pageMap ={};
  Map<int, String> titleMap = {
    0: "Map",
    1: "Gallery",
    2: "My Stories"
  };
  late Widget appBarContent, appBarText;
  late TextEditingController appBarController;

  setAppBar() {
    appBarText = Text(
      titleMap[currentIndex]!,
      style: TextStyle(
          letterSpacing: 2,
//          color: HexColor('#46ab2b'),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );

    appBarContent = appBarText;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
      setAppBar();
      appBarController.clear();
    });
  }

  void initState() {
    super.initState();
    appBarController = TextEditingController();
    pageMap = {0: MapPage(), 1: Gallery(),2: Stories()};
    setAppBar();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarContent,
        backgroundColor: HexColor("#3d2e2a").withOpacity(0.8),
        elevation: 0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: pageMap[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor("#3d2e2a"),
        fixedColor: Colors.white,
        unselectedItemColor: Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
        items: [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.map_outlined)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.photo_library_outlined)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.photo_album_outlined)),
        ],
      ),
    );
  }
}

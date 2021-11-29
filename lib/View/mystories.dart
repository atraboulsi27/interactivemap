import 'package:flutter/material.dart';
import 'package:interactivemap/Model/StoryClass.dart';
import 'package:interactivemap/View/widgets/StoryWidget.dart';
import 'addstory.dart';

class Stories extends StatefulWidget {
  @override
  _Stories createState() => _Stories();
}

class _Stories extends State<Stories> {
  @override
  Widget build(BuildContext context) {

    List<Story> stories = [];
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 5.0),
                    insets: EdgeInsets.symmetric(horizontal: 16.0)),
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Published",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Submitted",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Offline",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(child: StoryScroll(stories, context)),
                  Center(
                    child: Text("It's rainy here"),
                  ),
                  Center(
                    child: Text("It's sunny here"),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Icon(
              Icons.add,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3)),
          ),
          foregroundColor: Colors.brown,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddStory()));
          },
        ),
      ),
    );
  }
}

Widget StoryScroll(List<Story> stories, BuildContext context) {
  return ListView.builder(
      itemCount: stories.length,
      itemBuilder: (context, index) {
        return StoryWidget(stories[index], context);
      });
}

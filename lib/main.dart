// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:filter_menu/task_model.dart';
import 'package:filter_menu/task_row.dart';
import 'package:flutter/material.dart';

import 'animated_fab.dart';
import 'diagonal_clipper.dart';
import 'list_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  final double _imageHeight = 250.0;
  late ListModel listModel;
  bool showOnlyCompleted = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.teal,
      body: new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  Widget _buildImage() {
    return ClipPath(
      clipper: new DialogonalClipper(),
      child: Positioned.fill(
        bottom: null,
        child: Image.asset(
          "images/birds.jpg",
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Timeline",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          new Icon(Icons.linear_scale, size: 32.0, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('images/Me.jpg'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Sadek Belkhiria',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Product designer',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'My Tasks',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'FEBRUARY 8, 2015',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Color.fromARGB(255, 130, 130, 130),
      ),
    );
  }

  Widget _buildFab() {
    return new Positioned(
      top: _imageHeight - 100.0,
      right: -40.0,
      child: new AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}

List<Task> tasks = [
  new Task(
      name: "Catch up with Brian",
      category: "Mobile Project",
      time: "5pm",
      color: Colors.orange,
      completed: false),
  new Task(
      name: "Make new icons",
      category: "Web App",
      time: "3pm",
      color: Colors.cyan,
      completed: true),
  new Task(
      name: "Design explorations",
      category: "Company Website",
      time: "2pm",
      color: Colors.pink,
      completed: false),
  new Task(
      name: "Lunch with Mary",
      category: "Grill House",
      time: "12pm",
      color: Colors.cyan,
      completed: true),
  new Task(
      name: "Teem Meeting",
      category: "Hangouts",
      time: "10am",
      color: Colors.cyan,
      completed: true),
  new Task(
      name: "Coffe Meeting",
      category: "Coffee shop",
      time: "22pm",
      color: Colors.teal,
      completed: true),
  new Task(
      name: "Learn Flutter",
      category: "Sweet Home",
      time: "20pm",
      color: Colors.amber,
      completed: true),
  new Task(
      name: "Music Love",
      category: "Sweet Home",
      time: "21pm",
      color: Color.fromARGB(255, 77, 184, 6),
      completed: true),
];

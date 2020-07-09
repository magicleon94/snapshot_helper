import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snapshot_helper/snapshot_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapshotHelper example',
      home: MyHomePage(
        title: 'SnapshotHelper example',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final streamController = StreamController<int>.broadcast();
  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('Add value'),
            onPressed: () => streamController.add(Random().nextInt(100)),
          ),
          RaisedButton(
            child: Text('Add error'),
            onPressed: () => streamController.addError(
              Exception('An error'),
            ),
          ),
          Center(
            child: StreamBuilder<int>(
              stream: streamController.stream,
              builder: (context, snapshot) =>
                  SnapshotHelper.of(snapshot).getWidget(
                onData: (_) => DataWidget(),
                onLoading: (_) => LoadingWidget(),
                onError: (_) => ErrorWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Loading');
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Error');
  }
}

class DataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Data');
  }
}

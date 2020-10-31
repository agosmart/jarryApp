import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // top: true,
      // bottom: true,
      child: Scaffold(
        body: Center(child: Text('MAP')),
      ),
    );
  }
}

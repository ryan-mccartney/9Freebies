import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'utils.dart';
import 'package:overlay_support/overlay_support.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(child:MaterialApp(
      title: '9Freebies',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.lightBlue
      ),
      home: MyHomePage(title: '9Freebies'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //131516
  final Color _bColorMain = hexToColor("#1b2d36");

  //373D3F
  final Color _bColorSecondary = hexToColor("#1e2324");

  //AACCFF
  final Color _fColorMain = hexToColor("#AACCFF");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LoginScreen(
          backgroundColor1: _bColorMain,
          backgroundColor2: _bColorSecondary,
          highlightColor: Colors.blueAccent,
          foregroundColor: _fColorMain,
          logo: new AssetImage("assets/nine_freebies_logo.png"),
       ),
      )
    );
  }
}

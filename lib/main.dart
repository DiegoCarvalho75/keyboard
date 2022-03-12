import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './screens/home.dart';
import './services/udp_helper.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enablePlatformOverrideForDesktop();
  var sender = await UdpHelper.init();
  runApp(MyApp(sender: sender));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  final sender;

  const MyApp({this.sender});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U D P',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Home(sender: widget.sender),
          drawer: KeiboardDrawer(), //Home(),
        ),
      ),
    );
  }
}

class KeiboardDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 46, 167, 200),
      child: Column(
        children: [
          ListTile(
            hoverColor: Color.fromARGB(255, 124, 209, 233),
            onTap: () {},
            leading: Icon(Icons.account_tree_rounded),
            title: Text("Controllers"),
          ),
          Divider(),
          ListTile(
            hoverColor: Color.fromARGB(255, 124, 209, 233),
            onTap: () {},
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }
}

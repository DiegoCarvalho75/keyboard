import 'package:flutter/material.dart';
import 'package:keyboard/services/udp_helper.dart';
import 'package:udp/udp.dart';

import '../widgets/keyboard.dart';

class Home extends StatelessWidget {
  final UDP? sender;
  const Home({this.sender});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                UdpHelper.sendBroadcast();
              },
              child: Text("Broadcast"),
            ),
          ],
        )),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.pink[400],
            child: Keyboard(
              sender: sender,
            ),
          ),
        ),
      ],
    );
  }
}

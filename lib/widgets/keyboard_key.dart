import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

import '../models/notas.dart';
import '../services/udp_helper.dart';

class KeyboardKey extends StatelessWidget {
  final UDP? sender;
  final int index;
  final double? keyWidth;
  final double? keyHeight;
  final double? keyPadding;
  KeyboardKey({
    this.sender,
    required this.index,
    this.keyWidth,
    this.keyHeight,
    this.keyPadding,
  });

  Widget build(BuildContext context) {
    // print(keyWidth);
    int i = index;
    bool isSharp = mapaNotas[i]['noteName'].toString().contains('#');
    int distancia = (mapaNotas[i]['distancia'] - 1) - 21 as int;
    int midiNote = (mapaNotas[i]['midiNumber']) as int;

    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
        left: isSharp
            ? (distancia * (keyWidth! + keyPadding!)) +
                (keyWidth! / 2) +
                5.toDouble()
            : (distancia * (keyWidth! + keyPadding!)),
      ),
      height: isSharp ? (keyHeight!) * 2.6 : double.maxFinite,
      width: keyWidth,
      child: Listener(
        onPointerDown: (_) => UdpHelper.send(
          sender,
          "",
          144,
          midiNote,
          127,
        ),
        onPointerUp: (_) => UdpHelper.send(
          sender,
          "",
          128,
          midiNote,
          127,
        ),
        child: Material(
          color: isSharp ? Colors.red : Colors.deepPurpleAccent,
          child: InkWell(
            splashColor: Colors.amber.shade800,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                '${mapaNotas[i]['noteName'] + mapaNotas[i]['octave']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: isSharp ? Color(0xFF1866AF) : Color(0xFFCA0000),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

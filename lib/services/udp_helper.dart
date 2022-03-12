import 'dart:io';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:udp/udp.dart';

Future<String?> _initNetworkInfo() async {
  String? wifiIPv4;
  final NetworkInfo _networkInfo = NetworkInfo();
  try {
    wifiIPv4 = await _networkInfo.getWifiIP();
    return wifiIPv4;
  } on PlatformException catch (e) {
    throw Exception('PlatformException >>> $e');
  } catch (e) {
    throw Exception('Failed to get Wifi IPv4 >>> $e');
  }
}

class UdpHelper {
  static Future<UDP> init() async {
    bool _isBinded = false;
    UDP sender;
    final String? ipv4 = await _initNetworkInfo();
    try {
      if (ipv4 != null && ipv4.isNotEmpty) {
        sender = await UDP.bind(
          Endpoint.unicast(
            InternetAddress(ipv4),
            port: Port(43212),
          ),
        );
      } else {
        sender = await UDP.bind(
          Endpoint.any(
            port: Port(43212),
          ),
        );
      }
      var stream = sender.asStream();
      stream.listen(
        (datagram) {
          var str = String.fromCharCodes(datagram!.data);
          var adress = InternetAddress(str);
          if (adress.type.name == 'IPv4') {
            print("Endereço IPv4 ok");
          }
        },
        onDone: () => {print("Done")},
      );
      print('Sender binded to ${sender.local.address}');
      _isBinded = true;
      return sender;
    } catch (e) {
      throw Exception(e);
    }
  }

  static void sendBroadcast() async {
    try {
      final UDP sender = await UdpHelper.init();
      var dataLength = sender.send(
          [1],
          Endpoint.broadcast(
            port: Port(43211),
          ));
    } catch (e) {
      print(e);
    }
  }

  static Future<int?> send(
    UDP? sender,
    String receiverIP,
    int action,
    int note,
    int velocity,
  ) async {
    try {
      var dataLength = await sender?.send(
          [action, note, velocity],
          Endpoint.unicast(
            InternetAddress("192.168.0.21"),
            port: Port(43211),
          ));
      return dataLength;
    } catch (e) {
      throw Exception(e);
    }
  }
}

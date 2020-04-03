library view_common_connection_ball;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openinventory_staff_app/controllers/socket.dart';

class ConnectionBall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool connected = Provider.of<SocketController>(context).isConnected;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        radius: 10,
        backgroundColor: connected ? Colors.green : Colors.red,
      ),
    );
  }
}

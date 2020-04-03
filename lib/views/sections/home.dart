import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openinventory_staff_app/controllers/socket.dart';

class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool connected = Provider.of<SocketController>(context).isConnected;

    return ListView(
      children: <Widget>[if (connected) Text('You are connected')],
    );
  }
}

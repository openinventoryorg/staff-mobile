library controller_socket;

import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './base_url.dart';
import './token.dart';

class SocketController extends ChangeNotifier {
  static final apiSubstringRegex = RegExp('\/api\$');
  final SocketIOManager _manager = SocketIOManager();
  final String _token;
  final String _baseUrl;
  SocketIO _socket;
  bool _isConnected = false;

  SocketController({
    @required String token,
    @required String baseUrl,
  })  : _token = token,
        _baseUrl = baseUrl.replaceAll(apiSubstringRegex, '') {
    if (_baseUrl != null && _token != null) {
      _connectToSocket();
    }
  }

  factory SocketController.fromContext({@required BuildContext context}) {
    return SocketController(
      token: TokenController.of(context).token,
      baseUrl: BaseUrlController.of(context).baseUrl,
    );
  }

  static SocketController of(BuildContext context) {
    return Provider.of<SocketController>(context, listen: false);
  }

  @override
  void dispose() {
    if (_socket != null) {
      _manager.clearInstance(_socket);
    }
    super.dispose();
  }

  void onMessage(dynamic message) {
    try {
      String messageType = message['type'];
      String messageData = message['data'];
      DateTime messageTime = DateTime.tryParse(message['timestamp']);
      String messageClient = message['client'];
      String strMessage =
          "$messageType message from $messageClient: [$messageTime] $messageData";
      print(strMessage);
    } catch (_) {
      print(message);
    }
  }

  void _onError(dynamic error) {
    _setConnected = false;
    print(error);
  }

  void _onConnectError(dynamic error) {
    _setConnected = false;
    print('WebSocket connection failed');
    print(error);
  }

  void _onConnect(dynamic data) {
    _setConnected = true;
    print('Connected to Web Socket');
  }

  Future<void> sendMessage(message) async {
    if (_socket != null) {
      bool isConnected = await _socket.isConnected();
      if (isConnected) {
        await _socket.emit('client#message', message);
      }
    }
  }

  Future<void> _connectToSocket() async {
    var _options = SocketOptions(
      _baseUrl,
      nameSpace: '/staff',
      query: {'client': 'mobile', 'token': _token},
    );
    _socket = await _manager.createInstance(_options);
    _socket.onConnect(_onConnect);
    _socket.onConnectError(_onConnectError);
    _socket.onError(_onError);
    _socket.on('server#message', onMessage);
    _socket.connect();
  }

  bool get isConnected => _isConnected;

  set _setConnected(bool connected) {
    _isConnected = connected;
    notifyListeners();
  }
}

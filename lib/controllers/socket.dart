library controller_socket;

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './base_url.dart';
import './token.dart';

@immutable
class SocketController {
  final String _token;
  final String _baseUrl;

  SocketController({
    @required String token,
    @required String baseUrl,
  })  : _token = token,
        _baseUrl = baseUrl;

  factory SocketController.fromContext({@required BuildContext context}) {
    return SocketController(
      token: TokenController.of(context).token,
      baseUrl: BaseUrlController.of(context).baseUrl,
    );
  }

  static SocketController of(BuildContext context) {
    return Provider.of<SocketController>(context, listen: false);
  }
}

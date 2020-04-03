/// Controller which keeps track of base url
library controller_base_url;

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to keep track of the base url of the organization.
///
/// Base url is the server url that the app is connected to.
/// The api endpoint will be taken as `baseurl/api`.
/// All the requests will be sent taking this url as the reference url.
class BaseUrlController extends ChangeNotifier {
  /// Key used when storing the url in the storage
  static const storeKey = 'url';

  /// Base URL of the server.
  ///
  /// This controls the state of the [BaseUrlController].
  /// All the child widgets should be notified if this changes.
  String _baseUrl;

  /// Initializes and loads base url from storage asynchronously.
  BaseUrlController() {
    _loadBaseUrl();
  }

  /// Helper method to make consuming this object easy
  static BaseUrlController of(BuildContext context, [bool listen = false]) {
    return Provider.of<BaseUrlController>(context, listen: listen);
  }

  /// Loads base url from the storage.
  ///
  /// [SharedPreferences] is used since [_baseUrl] is not sensitive.
  /// All the listners will be notified when this is completed.
  Future<void> _loadBaseUrl() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    _baseUrl = _storage.getString(storeKey) ?? '';
    notifyListeners();
  }

  /// Changes base url to the given url.
  ///
  /// This also saves the url in the storage.
  /// All the listners will be notified when this is completed.
  Future<void> setBaseUrl(String url) async {
    url ??= 'http://localhost';
    _baseUrl = url;
    SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(storeKey, _baseUrl);
    notifyListeners();
  }

  /// Current organization server url; eg: https://organization.com
  String get baseUrl => _baseUrl ?? '';
}

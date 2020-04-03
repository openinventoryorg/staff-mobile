/// Class that handles all API calls (requests and responses)
library api_client;

import 'package:dio/dio.dart';

import '../controllers/token.dart';
import './requests/login.dart';
import './responses/error_message.dart';
import './responses/token.dart';

/// Class that handles all API calls (requests and responses)
class ApiClient {
  /// Base url for all the api calls
  final String _baseUrl;

  /// Dio object used to make API calls
  final Dio _dio;

  /// Initializer for client.
  ApiClient(this._baseUrl) : _dio = Dio() {
    _dio.options.headers["Content-Type"] = "application/json";
  }

  void setToken(TokenController tokenController) {
    tokenController.setHeaders(_dio);
  }

  /// Handler for the errors, returns the handled error
  Exception throwError(dynamic err) {
    if (err is DioError) {
      if (err.response == null) {
        return err;
      } else {
        var errorMessage = ErrorMessageResponse.fromJson(err.response.data);
        return Exception(errorMessage.message);
      }
    } else {
      return err;
    }
  }

  /// # POST /login
  Future<TokenResponse> login(String email, String password) async {
    try {
      String endPoint = '$_baseUrl/api/login';
      var request = LoginRequest(email: email, password: password);
      var response = await _dio.post(endPoint, data: request.toJson());
      return TokenResponse.fromJson(response.data);
    } catch (err) {
      if ((err is DioError && (err.response?.statusCode ?? 404) == 404) ||
          err is RangeError) {
        throw Exception('Invalid Server address. Server connection failed.');
      }
      throw throwError(err);
    }
  }

  /// # GET /demo
  Future<void> demo() async {
    try {
      String endPoint = '$_baseUrl/api/demo';
      var response = await _dio.get(endPoint);
      print(response);
    } catch (err) {
      throw throwError(err);
    }
  }
}

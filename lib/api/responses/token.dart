/// Token information from server
library response_token;

import 'package:json_annotation/json_annotation.dart';
import 'package:openinventory_staff_app/api/responses/user.dart';

part 'token.g.dart';

@JsonSerializable(nullable: false)
class TokenResponse {
  final String token;
  final UserResponse user;

  TokenResponse({this.token, this.user});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  String toString() {
    return '$user: $token';
  }
}

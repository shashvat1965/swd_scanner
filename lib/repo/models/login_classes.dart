import 'package:json_annotation/json_annotation.dart';
part 'login_classes.g.dart';

@JsonSerializable()
class LoginPostRequest {
  LoginPostRequest({
    this.username,
    this.password,
  });

  String? username;
  String? password;

  factory LoginPostRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginPostRequestToJson(this);
}

@JsonSerializable()
class JWTResponse {
  String? JWT;

  JWTResponse({
    this.JWT,
  });

  factory JWTResponse.fromJson(Map<String, dynamic> json) =>
      _$JWTResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JWTResponseToJson(this);
}


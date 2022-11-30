// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPostRequest _$LoginPostRequestFromJson(Map<String, dynamic> json) =>
    LoginPostRequest(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginPostRequestToJson(LoginPostRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

JWTResponse _$JWTResponseFromJson(Map<String, dynamic> json) => JWTResponse(
      JWT: json['JWT'] as String?,
    );

Map<String, dynamic> _$JWTResponseToJson(JWTResponse instance) =>
    <String, dynamic>{
      'JWT': instance.JWT,
    };

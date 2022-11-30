// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanPostRequest _$ScanPostRequestFromJson(Map<String, dynamic> json) =>
    ScanPostRequest(
      qr_code: json['qr_code'] as String?,
      show_id: json['show_id'] as int?,
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$ScanPostRequestToJson(ScanPostRequest instance) =>
    <String, dynamic>{
      'qr_code': instance.qr_code,
      'show_id': instance.show_id,
      'quantity': instance.quantity,
    };

ScanResponseOnNoError _$ScanResponseOnNoErrorFromJson(
        Map<String, dynamic> json) =>
    ScanResponseOnNoError(
      debug: json['debug'] == null
          ? null
          : Debug.fromJson(json['debug'] as Map<String, dynamic>),
      scan_code: json['scan_code'] as int?,
      display_message: json['display_message'] as String?,
    );

Map<String, dynamic> _$ScanResponseOnNoErrorToJson(
        ScanResponseOnNoError instance) =>
    <String, dynamic>{
      'debug': instance.debug,
      'display_message': instance.display_message,
      'scan_code': instance.scan_code,
    };

Debug _$DebugFromJson(Map<String, dynamic> json) => Debug(
      total_count: json['total_count'] as int,
      used_ticket_times: (json['used_ticket_times'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      unused_count: json['unused_count'] as int,
      used_count: json['used_count'] as int,
    );

Map<String, dynamic> _$DebugToJson(Debug instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'unused_count': instance.unused_count,
      'used_count': instance.used_count,
      'used_ticket_times': instance.used_ticket_times,
    };

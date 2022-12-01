// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prof_show_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowsData _$ShowsDataFromJson(Map<String, dynamic> json) => ShowsData(
      shows: (json['shows'] as List<dynamic>?)
          ?.map((e) => TicketData.fromJson(e as Map<String, dynamic>))
          .toList(),
      combos: (json['combos'] as List<dynamic>?)
          ?.map((e) => CombosData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShowsDataToJson(ShowsData instance) => <String, dynamic>{
      'shows': instance.shows,
      'combos': instance.combos,
    };

TicketData _$TicketDataFromJson(Map<String, dynamic> json) => TicketData(
      id: json['id'] as int?,
      event_code: json['event_code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TicketDataToJson(TicketData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_code': instance.event_code,
      'name': instance.name,
    };

CombosData _$CombosDataFromJson(Map<String, dynamic> json) => CombosData(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CombosDataToJson(CombosData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

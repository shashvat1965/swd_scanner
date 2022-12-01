import 'package:json_annotation/json_annotation.dart';

part 'prof_show_list.g.dart';

@JsonSerializable()
class ShowsData {
  List<TicketData>? shows;
  List<CombosData>? combos;

  ShowsData({
    this.shows,
    this.combos,
  });

  factory ShowsData.fromJson(Map<String, dynamic> json) =>
      _$ShowsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShowsDataToJson(this);
}

@JsonSerializable()
class TicketData {
  int? id;
  String? event_code;
  String? name;

  TicketData({
    this.id,
    this.event_code,
    this.name,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) =>
      _$TicketDataFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDataToJson(this);
}

@JsonSerializable()
class CombosData {
  int? id;
  String? name;

  CombosData({
    this.id,
    this.name,
  });

  factory CombosData.fromJson(Map<String, dynamic> json) =>
      _$CombosDataFromJson(json);

  Map<String, dynamic> toJson() => _$CombosDataToJson(this);
}

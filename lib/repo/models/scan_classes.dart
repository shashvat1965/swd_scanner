import 'package:json_annotation/json_annotation.dart';

part 'scan_classes.g.dart';

@JsonSerializable()
class ScanPostRequest {
  ScanPostRequest({
    this.qr_code,
    this.signature,
    this.show_id,
    this.quantity,
  });

  String? qr_code;
  int? show_id;
  String? signature;
  String? quantity;

  factory ScanPostRequest.fromJson(Map<String, dynamic> json) =>
      _$ScanPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScanPostRequestToJson(this);
}

@JsonSerializable()
class ScanResponseOnNoError {
  ScanResponseOnNoError({this.debug, this.scan_code, this.display_message});

  Debug? debug;
  String? display_message;
  int? scan_code;

  factory ScanResponseOnNoError.fromJson(Map<String, dynamic> json) =>
      _$ScanResponseOnNoErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ScanResponseOnNoErrorToJson(this);
}

@JsonSerializable()
class Debug {
  int total_count;
  int unused_count;
  int used_count;
  List<int> used_ticket_times;

  Debug(
      {required this.total_count,
      required this.used_ticket_times,
      required this.unused_count,
      required this.used_count});

  factory Debug.fromJson(Map<String, dynamic> json) => _$DebugFromJson(json);

  Map<String, dynamic> toJson() => _$DebugToJson(this);
}

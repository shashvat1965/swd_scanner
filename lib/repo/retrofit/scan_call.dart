import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../constants.dart';
import '../models/scan_classes.dart';

part 'scan_call.g.dart';

@RestApi(baseUrl: Constants.kBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/scan")
  Future<ScanResponseOnNoError> scanQr(
    @Header("Authorization") String jwt,
    @Body() ScanPostRequest body,
  );
}

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' as Dio;
import '../../constants.dart';
import '../models/login_classes.dart';
part 'login_api_call.g.dart';

@RestApi(baseUrl: Constants.kBaseUrl)
abstract class RestClient {
  factory RestClient(Dio.Dio dio, {String baseUrl}) = _RestClient;

  @POST("/wallet/auth")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<JWTResponse> getJWT(@Body() LoginPostRequest loginPostRequest);
}

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../constants.dart';
import '../models/login_classes.dart';
part 'login_api_call.g.dart';

@RestApi(baseUrl: Constants.kBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("login")
  Future<JWTResponse> getJWT(@Body() LoginPostRequest loginPostRequest);
}

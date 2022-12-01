import 'package:dio/dio.dart';

import '../repo/models/login_classes.dart';
import '../repo/retrofit/login_api_call.dart';

class JwtViewModel {
  Future<JWTResponse> getJwt(username, password) async {
    final dio = Dio();
    final client = RestClient(dio);
    LoginPostRequest loginPostRequest =
        LoginPostRequest(username: username, password: password);
    JWTResponse jwtResponse = JWTResponse();
    try {
      jwtResponse = await client.getJWT(loginPostRequest);
    } catch (e) {
      if (e.runtimeType == DioError) {
        throw Exception((e as DioError).response!.data);
      }
    }
    print("*****************");
    print(jwtResponse.JWT);
    return jwtResponse;
  }

  getError(username, password) async {
    final dio = Dio();
    final client = RestClient(dio);
    LoginPostRequest loginPostRequest =
        LoginPostRequest(username: username, password: password);
    try {
      await client.getJWT(loginPostRequest);
    } on DioError catch (e) {
      return e.toString();
    }
  }
}

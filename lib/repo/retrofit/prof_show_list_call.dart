import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../constants.dart';
import '../models/prof_show_list.dart';

part 'prof_show_list_call.g.dart';

@RestApi(baseUrl: Constants.kBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/shows")
  Future<ShowsData> getProfShowList(
    @Header("Authorization") String JWT,
  );
}

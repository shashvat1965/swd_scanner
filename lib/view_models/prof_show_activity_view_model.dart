import 'package:dio/dio.dart';

import '../repo/models/prof_show_list.dart';
import '../repo/retrofit/prof_show_list_call.dart';

class ProfShows {
  Future<Map<String, int>> getMapOfShows(String jwt) async {
    Map<String, int> tempMap = {};
    final dio = Dio();
    final client = RestClient(dio);
    ShowsData showsData = await client.getProfShowList("Bearer $jwt");
    for (int i = 0; i < showsData.shows!.length; i++) {
      tempMap[showsData.shows![i].name!] = showsData.shows![i].id!;
    }
    return tempMap;
  }
}

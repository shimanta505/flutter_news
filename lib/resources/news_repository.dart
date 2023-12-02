import 'package:get/get.dart';

import '../data/news_api.dart';

class NewsRepository {
  var newsApi = NewsApi();
  Future<Response> getNewsRepo() async {
    return await newsApi.getNewsApi();
  }
}

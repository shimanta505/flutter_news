import 'package:get/get.dart';

import '../utils/constants/app_constants.dart';

class NewsApi extends GetConnect {
  Future<Response> getNewsApi() async {
    Response response = await get(
        "https://newsapi.org/v2/everything?q=tesla&from=2023-11-28&sortBy=publishedAt&apiKey=${AppConstants.API_KEY}");
    return response;
  } //https://newsapi.org/v2/everything?q=tesla&from=2023-09-30&sortBy=publishedAt&apiKey=2304f11196514c6f82ae18cbf7253058
}// pub_32629b61e27ae64b4f569696377136339c4a9

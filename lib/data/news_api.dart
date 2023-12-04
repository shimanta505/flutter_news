import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/constants/app_constants.dart';

class NewsApi extends GetConnect {
  Future<Response> getNewsApi() async {
    Response response = await get(
        "https://newsapi.org/v2/everything?q=tesla&from=${pastDateFormat()}&sortBy=publishedAt&apiKey=${AppConstants.API_KEY}");
    return response;
  }

  //https://newsapi.org/v2/everything?q=tesla&from=2023-09-30&sortBy=publishedAt&apiKey=2304f11196514c6f82ae18cbf7253058

  String pastDateFormat() {
    var date = DateTime.now().subtract(const Duration(days: 1));
    var inputDate = DateTime.parse(date.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    print("${outputDate}previous day");
    return outputDate;
  }
}// pub_32629b61e27ae64b4f569696377136339c4a9

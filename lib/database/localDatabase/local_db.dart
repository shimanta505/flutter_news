import 'package:hive/hive.dart';

import '../../models/news_model.dart';

class LocalDb {
  static Box<NewsModel> get savedNewsBox {
    return Hive.box("saved_news");
  }
}
/* 








 */
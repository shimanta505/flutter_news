import 'package:flutter_news/database/localDatabase/local_db.dart';
import 'package:get/get.dart';
import '../models/news_model.dart';

class OfflineNewsController extends GetxController {
  List<NewsModel> offlineNews = [];

  bool _showLoading = true;
  bool get showLoading => _showLoading;

  void changeLoading(bool showLoading) {
    _showLoading = showLoading;
    update();
  }

  void loadData() {
    var box = LocalDb.savedNewsBox;
    offlineNews = [];
    offlineNews = box.values.toList()..reversed;
    update();
  }

  Future<void> deleteNews(int index) async {
    var box = LocalDb.savedNewsBox;
    await box.deleteAt(index);
    loadData();
  }
}

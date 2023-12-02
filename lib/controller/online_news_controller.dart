import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_news/data/news_api.dart';
import 'package:flutter_news/database/localDatabase/local_db.dart';
import 'package:get/get.dart';

import '../models/news_model.dart';

class OnlineNewsController extends GetxController {
  List<Map> data = [];
  List<NewsModel> newsList = [];

  bool _showLoading = true;
  bool get showLoading => _showLoading;

  void changeLoading(bool showLoading) {
    _showLoading = showLoading;
    update();
  }

  Future<void> saveDataToLocalDb(NewsModel newsModel) async {
    if (newsModel.urlToImage != null) {
      await FileDownloader.downloadFile(
        url: newsModel.urlToImage.toString().trim(),
        downloadDestination: DownloadDestinations.appFiles,
        notificationType: NotificationType.progressOnly,
        onProgress: ((fileName, progress) {}),
        onDownloadCompleted: (path) {
          print(path);
          newsModel.localDbImgDestination = path;
        },
        onDownloadError: (errorMessage) {
          print("error massage$errorMessage");
          return;
        },
      );
    }
    LocalDb.savedNewsBox.add(newsModel);
    newsModel.save();
  }

  Future<void> getNews() async {
    try {
      Response response = await NewsApi().getNewsApi();
      if (response.statusCode == 200) {
        print("Ok");
        String rawJson = '{"name":"Mary","age":30}';
        print(response.body['status']);

        List articles = response.body['articles'];
        print(articles.length);
        newsList = [];
        for (var element in articles) {
          newsList.add(NewsModel.fromJson(element));
        }
        update();
        print("list length ${newsList.length}");
        // print(json['status']);
      } else {
        print(response.statusCode);
        print("status code");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

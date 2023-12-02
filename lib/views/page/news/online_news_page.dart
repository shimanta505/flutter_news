import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_news/controller/offline_news_controller.dart';
import 'package:flutter_news/controller/online_news_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/news_model.dart';
import '../../../route/app_route.dart';
import '../../../utils/dimensions/dimensions.dart';

class OnlineNewsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OnlineNewsController>(() => OnlineNewsController()); // here!
    Get.lazyPut<OfflineNewsController>(() => OfflineNewsController()); // here!
  }
}

class OnlineNewsPage extends StatelessWidget {
  OnlineNewsPage({super.key});

  final controller = Get.put<OnlineNewsController>(OnlineNewsController());
  final offlineController =
      Get.put<OfflineNewsController>(OfflineNewsController());

  Future<void> loadData() async {
    await controller.getNews();
    offlineController.loadData();
    print(offlineController.offlineNews.length);
    print("completed");
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Column(
      children: [
        Expanded(
          // onlline news
          child: GetBuilder<OnlineNewsController>(
            builder: ((controller) {
              return ListView.builder(
                itemCount: controller.newsList.length,
                itemBuilder: ((context, index) {
                  print("length ${controller.newsList.length}");
                  NewsModel news = controller.newsList[index];

                  return Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10, bottom: Dimensions.height10),
                    child: InkWell(
                      onTap: () =>
                          Get.toNamed(AppRoute.detailsPage, arguments: news),
                      child: Card(
                        elevation: 15,
                        // shadowColor: Colors.transparent,
                        color: context.theme.scaffoldBackgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: Dimensions.height220,
                              child: news.urlToImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: news.urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: Dimensions.height200,
                                          width: Get.width,
                                          margin: EdgeInsets.all(
                                              Dimensions.height10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radious20),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        );
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.error_rounded);
                                      },
                                    )
                                  : const Icon(Icons.error),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Container(
                              padding: EdgeInsets.all(Dimensions.height10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        // title/ HEADLINE
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            title(news.title.toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.font16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(dateTimeFormat(
                                              news.publishedAt.toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await controller
                                                .saveDataToLocalDb(news);
                                          },
                                          icon: const Icon(Icons.download)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }

  void downloadImage(String url) {
    FileDownloader.downloadFile(
      url: url.trim(),
      downloadDestination: DownloadDestinations.appFiles,
      notificationType: NotificationType.progressOnly,
      onProgress: ((fileName, progress) {}),
      onDownloadCompleted: (path) {
        print(path);
      },
      onDownloadError: (errorMessage) {
        return print("error massage$errorMessage");
      },
    );
  }

  Widget titleText(String title) => Text(
        title,
        style:
            GoogleFonts.roboto(fontSize: Dimensions.font16, letterSpacing: 1.2),
      );

  String title(String title) {
    if (title.length <= 25) {
      return title;
    } else {
      return '${title.substring(0, 25)}...';
    }
  }

  String dateTimeFormat(String date) {
    DateTime formatedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
    var inputDate = DateTime.parse(formatedTime.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  void pastDateFormat() {
    var date = DateTime.now().subtract(const Duration(days: 1));
    var inputDate = DateTime.parse(date.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    print("${outputDate}previous day");
  }
}

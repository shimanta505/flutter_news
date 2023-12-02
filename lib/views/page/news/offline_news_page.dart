import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_news/controller/offline_news_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/news_model.dart';
import '../../../route/app_route.dart';
import '../../../utils/dimensions/dimensions.dart';

class OfflineNewsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OfflineNewsController>(() => OfflineNewsController()); // here!
  }
}

class OfflineNewsPage extends StatelessWidget {
  OfflineNewsPage({super.key});

  final OfflineNewsController controller = Get.find<OfflineNewsController>();

  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Column(
      children: [
        Expanded(
          // onlline news
          child: GetBuilder<OfflineNewsController>(
            builder: ((controller) {
              return controller.offlineNews.isEmpty
                  ? Expanded(
                      child: Image.asset("assets/errorImage/no-data-found.png"),
                    )
                  : ListView.builder(
                      itemCount: controller.offlineNews.length,
                      itemBuilder: ((context, index) {
                        print("length ${controller.offlineNews.length}");
                        NewsModel news = controller.offlineNews[index];

                        return Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10),
                          child: InkWell(
                            onTap: () => Get.toNamed(AppRoute.detailsPage,
                                arguments: news),
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
                                    child: localDbImage(index),
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Container(
                                    padding:
                                        EdgeInsets.all(Dimensions.height10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Dimensions.font16),
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
                                                Text(dateTimeFormat(news
                                                    .publishedAt
                                                    .toString())),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                await controller
                                                    .deleteNews(index);
                                              },
                                              icon: const Icon(Icons.delete),
                                            )
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

  Widget localDbImage(int index) {
    var newsModel = controller.offlineNews[index];
    if (newsModel.localDbImgDestination != null) {
      var image = FileImage(File(newsModel.localDbImgDestination.toString()));
      return Container(
        child: Image(
          fit: BoxFit.cover,
          image: image,
          frameBuilder: (context, child, frame, wasSynchronuslyLoaded) {
            return Container(
              height: Dimensions.height200,
              width: Get.width,
              margin: EdgeInsets.all(Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radious20),
                image: DecorationImage(image: image, fit: BoxFit.cover),
              ),
            );
          },
        ),
      );
    } else {
      return const Icon(Icons.error);
    }
  }

  Widget localDbTest(String path) {
    print("path$path");
    return Container(
      child: Image(
        image: FileImage(File(path)),
      ),
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

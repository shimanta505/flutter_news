import 'package:flutter/material.dart';
import 'package:flutter_news/authentication/authentication.dart';
import 'package:flutter_news/utils/dimensions/dimensions.dart';
import 'package:flutter_news/views/page/news/offline_news_page.dart';
import 'package:flutter_news/views/page/news/online_news_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../../../controller/home_screen_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeScreenController>(() => HomeScreenController()); // here!
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller;

  @override
  void initState() {
    // TODO: implement initState\
    controller = Get.find<HomeScreenController>();
    super.initState();
  }

  List<Widget> screens() {
    return [
      OnlineNewsPage(),
      OfflineNewsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("is logged in or not${AuthService.isLOggedIn()}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("news"),
        actions: [
          IconButton(
              onPressed: () => AuthService.signout(),
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currIndex.value,
          onTap: (index) {
            controller.currIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.offline_share), label: "offline"),
          ],
        ),
      ),
      body: Obx(() => screens()[controller.currIndex.value]),
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
}
/*


*/
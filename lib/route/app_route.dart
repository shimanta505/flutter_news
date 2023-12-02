import 'package:flutter_news/authentication/signin_page.dart';
import 'package:flutter_news/authentication/signup_page.dart';
import 'package:flutter_news/views/page/detailsPage/details_page.dart';
import 'package:flutter_news/views/page/homePage/home_page.dart';
import 'package:flutter_news/views/page/news/offline_news_page.dart';
import 'package:flutter_news/views/page/news/online_news_page.dart';
import 'package:flutter_news/views/page/onBoardingPage/on_boarding_page.dart';
import 'package:get/get.dart';


class AppRoute extends GetPageRoute {
  static const String home = '/home';

  static const String signUp = '/sign_up';
  static const String signIn = '/sign_in';
  static const String onboardingPage = '/onboarding_page';
  static const String onlineNews = '/online_news';
  static const String offlineNews = '/offline_news';
  static const String detailsPage = '/details_page';

  appRoutes() => [
        GetPage(
          name: home,
          page: () => const HomePage(),
          binding: HomeBindings(),
        ),
        GetPage(
          name: signUp,
          page: () => SignupPage(),
        ),
        GetPage(
          name: signIn,
          page: () => const SigninPage(),
        ),
        GetPage(
          name: onboardingPage,
          page: () => OnboardingPage(),
          binding: OnboardingPageBinding(),
        ),
        GetPage(
          name: onlineNews,
          page: () => OnlineNewsPage(),
          binding: OnlineNewsBinding(),
          transitionDuration: const Duration(milliseconds: 100),
        ),
        GetPage(
            name: offlineNews,
            page: () => OfflineNewsPage(),
            binding: OfflineNewsBinding()),
        GetPage(
          name: detailsPage,
          page: () => DetailsPage(newsModel: Get.arguments),
        ),
      ];
}

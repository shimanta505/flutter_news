import '../models/onboarding_info.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo("assets/images/order.png", "title", "description"),
    OnboardingInfo("assets/images/deliver.png", "title", "description"),
    OnboardingInfo("assets/images/cook.png", "title", "description"),
  ];
}

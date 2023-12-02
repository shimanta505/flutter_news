import 'package:flutter/material.dart';
import 'package:flutter_news/route/app_route.dart';
import 'package:flutter_news/utils/dimensions/dimensions.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding_controller.dart';

class OnboardingPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});
  final controller = OnboardingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: PageView.builder(
                  onPageChanged: (index) {
                    controller.selectedIndex.value = index;
                  },
                  itemCount: controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    var pageInfo = controller.onboardingPages[index];
                    print("height ${Get.height}");
                    print("width ${Get.width}");
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 600,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(pageInfo.imageAsset)),
                            ),
                          ),
                          Text(pageInfo.title.toString()),
                          Text(pageInfo.description.toString()),
                        ],
                      ),
                    );
                  }),
            ),
            Obx(
              () => Positioned(
                bottom: 20,
                left: 10,
                child: Row(
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? Colors.red
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.selectedIndex.value == 2) {
                return Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.signUp);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: Colors.purple,
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: Dimensions.font16),
                      ),
                    ));
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}

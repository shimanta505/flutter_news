import 'package:hive/hive.dart';
part 'onboarding_info.g.dart';

@HiveType(typeId: 3)
class OnboardingInfo {
  @HiveField(0)
  final imageAsset;
  @HiveField(1)
  final title;
  @HiveField(2)
  final description;

  OnboardingInfo(this.imageAsset, this.title, this.description);
}

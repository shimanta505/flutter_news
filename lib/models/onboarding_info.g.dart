// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnboardingInfoAdapter extends TypeAdapter<OnboardingInfo> {
  @override
  final int typeId = 3;

  @override
  OnboardingInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnboardingInfo(
      fields[0] as dynamic,
      fields[1] as dynamic,
      fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, OnboardingInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageAsset)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

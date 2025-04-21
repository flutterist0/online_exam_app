// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinResponseModel _$PinResponseModelFromJson(Map<String, dynamic> json) =>
    PinResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PinResponseModelToJson(PinResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

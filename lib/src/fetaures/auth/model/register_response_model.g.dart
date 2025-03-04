// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      token: json['token'] as String?,
      expiration: json['expiration'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiration': instance.expiration,
      'userId': instance.userId,
    };

import 'package:json_annotation/json_annotation.dart';
part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  RegisterResponseModel({this.token, this.expiration, this.userId});
  final String? token;
  final String? expiration;
  final int? userId;
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

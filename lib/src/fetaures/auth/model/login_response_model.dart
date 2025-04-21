import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  LoginResponseModel(this.pinCode, {this.token, this.expiration, this.userId});

  final String? token;
  final String? expiration;
  final int? userId;
  final String? pinCode;
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

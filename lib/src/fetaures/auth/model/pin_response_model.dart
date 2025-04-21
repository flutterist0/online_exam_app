import 'package:json_annotation/json_annotation.dart';
part 'pin_response_model.g.dart';

@JsonSerializable()
class PinResponseModel {
  PinResponseModel({this.success, this.message});
  final bool? success;
  final String? message;

  factory PinResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PinResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PinResponseModelToJson(this);
}

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

class ErrorResponseModel extends Equatable {
  const ErrorResponseModel({
    this.message,
    this.detail,
    this.suggestions,
    this.username,
    this.email,
    this.phoneNumber,
  });

  final String? message, detail;
  final List<String>? suggestions, username, email, phoneNumber;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      message: json["message"],
      detail: json["detail"],
      suggestions: json["suggestions"] == null
          ? []
          : List<String>.from(json["suggestions"]!.map((x) => x)),
      username: json["username"] == null
          ? []
          : List<String>.from(json["username"]!.map((x) => x)),
      email: json["email"] == null
          ? []
          : List<String>.from(json["email"]!.map((x) => x)),
      phoneNumber: json["phone_number"] == null
          ? []
          : List<String>.from(json["phone_number"]!.map((x) => x)),
    );
  }

  @override
  String toString() {
    return "$message, $detail, $suggestions, $username $email $phoneNumber";
  }

  @override
  List<Object?> get props => [
        message,
        detail,
        suggestions,
        username,
        email,
        phoneNumber,
      ];
}

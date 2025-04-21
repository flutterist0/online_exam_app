class SetPinRequestModel {
  final int userId;
  final String pinCode;

  SetPinRequestModel({
    required this.userId,
    required this.pinCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'pinCode': pinCode,
    };
  }
}

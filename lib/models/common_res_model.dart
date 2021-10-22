class CommonResModel {
  String? status;
  String? message;

  CommonResModel({this.status, this.message});

  factory CommonResModel.fromJson(Map<String, dynamic> json) {
    return CommonResModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

// {
//     "status": "success",
//     "data": {
//         "name": "Test",
//         "salary": "123",
//         "age": "123",
//         "id": 6835
//     },
//     "message": "Successfully! Record has been added."
// }
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

class EmployeeModel {
  String? name;
  String? age;
  String? salary;

  EmployeeModel({this.name, this.age, this.salary});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: json['name'],
      age: json['age'],
      salary: json['salary'],
    );
  }
}

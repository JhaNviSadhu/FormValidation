import 'dart:convert';

import 'package:api_call_post/api_constant.dart';
import 'package:api_call_post/constant.dart';
import 'package:api_call_post/models/common_res_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _ageController = TextEditingController();
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  void onLogin() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // bool isValid = _formkey.currentState?.validate() ?? false;
    if (isValid()) {
      //ApI call
      final dynamic data = <String, dynamic>{
        'name': _nameController.text.trim(),
        'salary': _salaryController.text.trim(),
        'age': _ageController.text.trim()
      };

      setState(() {
        isLoading = true;
      });
      var url = Uri.parse('${APIConstant.baseUrl}${APIConstant.userList}');
      final response = await http.post(url, body: data);
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> decodedJson = json.decode(response.body);
        CommonResModel commonResModel = CommonResModel.fromJson(decodedJson);
        if (commonResModel.status == 'success') {
          Fluttertoast.showToast(
              msg: commonResModel.message ?? '',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  bool isValid() {
    if (_nameController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please check your details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Validation"),
      ),
      body: SafeArea(
        child: Form(
          // key: _formkey,

          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  validator: (value) {
                    print(value?.isEmpty);

                    if (value?.isEmpty ?? true) {
                      return "Enter your name";
                    }
                  },
                  decoration: textFieldDecoration.copyWith(
                    hintText: "Enter your name",
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _salaryController,
                  validator: (value) {
                    print(value?.isEmpty);
                    if (value?.isEmpty ?? true) {
                      return "Enter your salary";
                    }
                  },
                  decoration: textFieldDecoration.copyWith(
                    hintText: "Enter your salary",
                    labelText: "Salary",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: _ageController,
                  validator: (value) {
                    print(value?.isEmpty);
                    if (value?.isEmpty ?? true) {
                      return "Enter your age";
                    }
                  },
                  decoration: textFieldDecoration.copyWith(
                    hintText: "Enter your age",
                    labelText: "Age",
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: onLogin,
                        child: const Text("Login"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

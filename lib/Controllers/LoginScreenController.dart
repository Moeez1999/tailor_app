import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  bool validateFields = false;

}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tailor_book/Model%20Classes/AddNewRecordModelClass.dart';

class AddRecordController extends GetxController{

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController arm = TextEditingController();
  TextEditingController kennel = TextEditingController();
  TextEditingController teera = TextEditingController();
  TextEditingController chest = TextEditingController();
  TextEditingController boundary = TextEditingController();
  TextEditingController paincha = TextEditingController();
  TextEditingController shalwarLength = TextEditingController();
  TextEditingController cuff = TextEditingController();
  TextEditingController frontPocket = TextEditingController();
  TextEditingController shalwarPocket = TextEditingController();
  TextEditingController boundaryShapes = TextEditingController();
  TextEditingController design = TextEditingController();
  TextEditingController collerTip = TextEditingController();
  TextEditingController sidePockets = TextEditingController();




  AddRecordModel? addRecordModel;

  @override
  void onInit() {
    if(Get.arguments != null){
        print("Arguments : "+Get.arguments.toString());
    }
    // TODO: implement onInit
    super.onInit();
  }




}
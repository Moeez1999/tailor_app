import 'package:get/get.dart';

class HomeController extends GetxController{
  var data = [].obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    // data = await Database.readRecords();
    // print("we got "+data.toString());
    super.onReady();
  }


}
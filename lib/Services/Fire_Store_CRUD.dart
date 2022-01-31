import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_book/Controllers/AddNewRecordController.dart';
import 'package:tailor_book/Model%20Classes/AddNewRecordModelClass.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';
import 'package:tailor_book/UI%20Screens/HomeScreen.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _dataBase.collection('Users');

class Database {
  // static String? userUid = "03226428067";

  //Check user Exist or Not

  /// Check If Document Exists
  static Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var doc = await _mainCollection.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

//  Write Operation Create User
  static Future<void> registerUser({
    required String userName,
    required String userNumber,
  }) async {
    SharedPreferences prefs = await Constants.prefs;
    bool docExists = await checkIfDocExists(userNumber);
    if (docExists == true) {
      prefs.setBool('login', true);
      print("Login Check ${GetStorage().read('login').toString()}");
      Get.offAll(() => HomeScreen());
      print("Document exists in Firestore? " + docExists.toString());
    } else {
      print("Document exists in Firestore? " + docExists.toString());
      DocumentReference documentReferencer = _mainCollection
          .doc(userNumber)
          .collection('UserInfo')
          .doc("UserInfo");

      Map<String, dynamic> data = <String, dynamic>{
        "User_Name": userName,
        "User_Number": userNumber,
      };

      await documentReferencer.set(data).whenComplete(() async {
        prefs.setBool('login', true);
        Get.offAll(() => HomeScreen());
      }).catchError((e) => print(e));
    }
  }

  //Insert New Record
  static Future<void> insertRecord({
    required AddRecordModel recModel,
  }) async {
    String? _userNumber = GetStorage().read('number');
    DocumentReference documentReferencer =
        _mainCollection.doc("$_userNumber").collection('Data').doc();
    DocumentSnapshot _documentReferencer = await documentReferencer.get();
    recModel.docId = _documentReferencer.reference.id.toString();
    recModel.createdAt = Timestamp.now();
    final data = recModel.toJson();
    print(data.runtimeType);
    print(data);
    await documentReferencer.set(data).whenComplete(() async {
      Get.delete<AddRecordController>();
      print("Notes item added to the database");
    }).catchError((e) => print("failed" + e));
  }

  //  Read Operation
  static Future<dynamic> readRecords() async {
    String? _userNumber = GetStorage().read('number');
    Stream<QuerySnapshot> recordItemCollection = _mainCollection
        .doc("$_userNumber")
        .collection('Data')
        .orderBy("createdAt", descending: true)
        .snapshots();
    print(
        "Record Items are : " + _mainCollection.snapshots().length.toString());

    var recordData = [];
    await recordItemCollection.forEach((e) {
      for (var value in e.docs) {
        print("Check data ${value.data()}");
        recordData.add(value.data());
      }
      print("Check data final ${recordData.toString()}");
    });
    return recordData;
  }

//  Delete Data
  static Future<void> deleteItem({
    required String docId,
  }) async {
    String? _userNumber = GetStorage().read('number');
    DocumentReference documentReferencer =
        _mainCollection.doc(_userNumber).collection('Data').doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => Get.offAll(() => HomeScreen()))
        .catchError((e) => print(e));
  }

//  Update Record

  static Future<void> updateRecord({
    required AddRecordModel recModel,
  }) async {
    String? _userNumber = GetStorage().read('number');
    // DocumentReference documentReferencer =;

    recModel.createdAt = Timestamp.now();
    final data = recModel.toJson();
    print(data.runtimeType);
    print(data);
    await _mainCollection
        .doc("$_userNumber")
        .collection('Data')
        .doc('${recModel.docId}')
        .update(data)
        .whenComplete(() async {
      Get.delete<AddRecordController>();
      Get.offAll(() => HomeScreen());
      print("Notes item added to the database");
    }).catchError((e) => print("failed" + e));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailor_book/Services/Fire_Store_CRUD.dart';
import 'package:tailor_book/UI%20Screens/AddRecordScreen.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, @required this.recordData}) : super(key: key);
  final recordData;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title: Text(widget.recordData['Name'].toString()),
          actions: [
            IconButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: Icon(Icons.delete))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.primaryColor,
          child: Icon(Icons.edit),
          onPressed: () {
            Get.to(()=>AddRecord(appbarTitle: "Update Record",buttonText: "Update Now",data: widget.recordData,));
          },
        ),
        persistentFooterButtons: [
          Container(
            color: Constants.primaryColor,
            height: double.infinity,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  splashFactory: InkSplash.splashFactory,
                  textStyle: TextStyle(color: Colors.white)),
              onPressed: () {
                Constants.callNumber(widget.recordData['Number'].toString());
                print("caller");
              },
              child: Text(
                "Call Now".tr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        body: Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cards(
                  widget.recordData[Constants.detailItems[index]].toString(),
                  Constants.detailItems[index]);
            },
            itemCount: Constants.detailItems.length,
          ),
        ),
      ),
    );
  }

  //Alert Dialogue for delete
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel".tr, style: TextStyle(
        color: Colors.red,
      ),),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Yes".tr),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        shape: StadiumBorder(),
      ),
      onPressed: () {
        Database.deleteItem(docId: widget.recordData["doc_Id"].toString());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Do you really want to delete it?".tr),
      // content: Text(
      //     "Do you want to delete this Record"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//  Cards
  Widget cards(String value, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 30.0, top: 10.0, bottom: 10.0, right: 30),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF0A3966),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xFF0A3966),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // width: 330,
        // height: 45,
        // decoration: BoxDecoration(
        // color: Colors.white,
        // borderRadius: BorderRadius.all(
        //   Radius.circular(10),
        // ),
        // boxShadow: [
        //   BoxShadow(
        //       color: primaryColor.withOpacity(0.3),
        //       blurRadius: 4.0,
        //       spreadRadius: 1.0,
        //       offset: Offset(0.0, 1.0))
        // ]),
      ),
    );
  }
}

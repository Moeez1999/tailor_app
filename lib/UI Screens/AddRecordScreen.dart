import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tailor_book/Controllers/AddNewRecordController.dart';
import 'package:tailor_book/Model%20Classes/AddNewRecordModelClass.dart';
import 'package:tailor_book/Services/Fire_Store_CRUD.dart';
import 'package:tailor_book/Services/admob%20Helper.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';

import 'HomeScreen.dart';

class AddRecord extends StatefulWidget {
  final String appbarTitle;
  final String buttonText;
  final data;

  AddRecord(
      {Key? key,
      required this.appbarTitle,
      required this.buttonText,
      this.data})
      : super(key: key);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  AddRecordController addRecordController = Get.find<AddRecordController>();

  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Get.offAll(()=>HomeScreen());
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadInterstitialAd();
    if (widget.data != null) {
      addRecordController.name.text = widget.data["Name"];
      addRecordController.number.text = widget.data["Number"];
      addRecordController.address.text = widget.data["Address"];
      addRecordController.length.text = widget.data["Length"];
      addRecordController.paincha.text = widget.data["Paincha"];
      addRecordController.sidePockets.text = widget.data["Side Pockets"];
      addRecordController.collerTip.text = widget.data["Collar Tip"];
      addRecordController.boundaryShapes.text = widget.data["Boundary Shape"];
      addRecordController.boundary.text = widget.data["Boundary"];
      addRecordController.frontPocket.text = widget.data["Front Pocket"];
      addRecordController.teera.text = widget.data["Teera"];
      addRecordController.shalwarPocket.text = widget.data["Shalwar Pocket"];
      addRecordController.cuff.text = widget.data["Cuff"];
      addRecordController.shalwarLength.text = widget.data["Shalwar Length"];
      addRecordController.arm.text = widget.data["Arm"];
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(widget.appbarTitle),
      ),
      persistentFooterButtons: [
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: Constants.primaryColor,
            height: double.infinity,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  splashFactory: InkSplash.splashFactory,
                  textStyle: TextStyle(color: Colors.white)),
              onPressed: () {
                var _search =
                    Constants.setSearchParam(addRecordController.name.text);
                AddRecordModel _addRecordModel = AddRecordModel(
                  name: addRecordController.name.text,
                  number: addRecordController.number.text,
                  address: addRecordController.address.text,
                  arm: addRecordController.arm.text,
                  frontPocket: addRecordController.frontPocket.text,
                  shalwarPocket: addRecordController.shalwarPocket.text,
                  boundary: addRecordController.boundary.text,
                  cuff: addRecordController.cuff.text,
                  length: addRecordController.length.text,
                  shalwarLength: addRecordController.shalwarLength.text,
                  teera: addRecordController.teera.text,
                  searchKeyword: _search,
                  boundaryShape: addRecordController.boundaryShapes.text,
                  collarTip: addRecordController.collerTip.text,
                  sidePockets: addRecordController.sidePockets.text,
                  paincha: addRecordController.paincha.text
                );
                  print("ready data is :" + _addRecordModel.toString());
                  // if(widget.buttonText.toString().contains("save")){
                  if (addRecordController.sidePockets.text.isEmpty ||
                      addRecordController.length.text.isEmpty ||
                      addRecordController.name.text.isEmpty ||
                      addRecordController.boundary.text.isEmpty ||
                      addRecordController.cuff.text.isEmpty ||
                      addRecordController.teera.text.isEmpty ||
                      addRecordController.arm.text.isEmpty
                  ) {
                    Get.showSnackbar(GetBar(
                      title: "Error",
                      isDismissible: true,
                      icon: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                      duration: Duration(milliseconds: 1500),
                      message: "Fill all Fields",
                    ));
                  } else {
                    if(widget.buttonText.contains('Save')){
                      Database.insertRecord(recModel: _addRecordModel).whenComplete(() {
                        if (_isInterstitialAdReady) {
                          _interstitialAd?.show();
                        } else {
                          Get.offAll(()=>HomeScreen());
                        }
                      });
                    }else{
                      _addRecordModel.docId = widget.data["doc_Id"];
                      Database.updateRecord(recModel: _addRecordModel);
                    }

                  }
                // }
              },
              child: Text(
                widget.buttonText.toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              inputField("Name".tr, "Name".tr, Icons.account_circle,
                  addRecordController.name, TextInputType.text, context),
              inputField("Number".tr, "Number".tr, Icons.account_circle,
                  addRecordController.number, TextInputType.phone, context),
              inputField("Address".tr, "Address".tr, Icons.account_circle,
                  addRecordController.address, TextInputType.text, context),
              inputField("Length".tr, "Length".tr, Icons.account_circle,
                  addRecordController.length, TextInputType.number, context),
              inputField("Arm".tr, "Arm".tr, Icons.account_circle,
                  addRecordController.arm, TextInputType.number, context),
              inputField("Teera".tr, "Teera".tr, Icons.account_circle,
                  addRecordController.teera, TextInputType.number, context),
              inputField("boundary".tr, "boundary".tr, Icons.account_circle,
                  addRecordController.boundary, TextInputType.number, context),
              inputField(
                  "ShalwarLength".tr,
                  "ShalwarLength".tr,
                  Icons.account_circle,
                  addRecordController.shalwarLength,
                  TextInputType.number,
                  context),
              inputField("paincha".tr, "paincha".tr, Icons.account_circle,
                  addRecordController.paincha, TextInputType.number, context),
              inputField("Collar tip".tr, "Collar tip".tr, Icons.account_circle,
                  addRecordController.collerTip, TextInputType.number, context),
              inputField("Cuff".tr, "Cuff".tr, Icons.account_circle,
                  addRecordController.cuff, TextInputType.number, context),
              inputField(
                  "front pocket".tr,
                  "front pocket".tr,
                  Icons.account_circle,
                  addRecordController.frontPocket,
                  TextInputType.text,
                  context),
              inputField(
                  "side pockets".tr,
                  "side pockets".tr,
                  Icons.account_circle,
                  addRecordController.sidePockets,
                  TextInputType.text,
                  context),
              inputField(
                  "shalwar pocket".tr,
                  "shalwar pocket".tr,
                  Icons.account_circle,
                  addRecordController.shalwarPocket,
                  TextInputType.text,
                  context),
              inputField(
                  "BoundaryShape".tr,
                  "shalwar pocket".tr,
                  Icons.account_circle,
                  addRecordController.boundaryShapes,
                  TextInputType.text,
                  context),
            ],
          ),
        ),
      ),
    );
  }
}

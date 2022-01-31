import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_book/Controllers/AddNewRecordController.dart';
import 'package:tailor_book/Services/MultiLanguageService.dart';
import 'package:tailor_book/Services/admob%20Helper.dart';
import 'package:tailor_book/UI%20Screens/AddRecordScreen.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';
import 'package:tailor_book/UI%20Screens/DetailScreen.dart';
import 'package:tailor_book/UI Screens/Constants.dart';

RxString searchValue = "null".obs;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxBool isSearching = false.obs;
  bool _isSelectedLanguage = false;
  LocalizationService _localizationService = LocalizationService();
  AddRecordController addRecordController = Get.put(AddRecordController());

  // TODO: Add _bannerAd
  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  RxBool _isBannerAdReady = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady.value = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  static String number = GetStorage().read('number');
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Users')
      .doc("$number")
      .collection("Data")
      .orderBy("createdAt", descending: true)
      .snapshots();

  // final Stream<QuerySnapshot> _searchStream =

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title: !isSearching.value == true
              ? Text('Tailor Book'.tr)
              : TextField(
                  autofocus: isSearching.value,
                  textCapitalization: TextCapitalization.words,
                  onSubmitted: (value) {
                    searchValue.value = value;
                  },
                  onChanged: (value) {
                    searchValue.value = value;
                    print("search val is :" + searchValue.value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "SearchHere".tr,
                      hintStyle: TextStyle(color: Colors.white)),
                ),
          actions: <Widget>[
            isSearching.value
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      isSearching.value = false;
                      searchValue.value = "null";
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      isSearching.value = true;
                    },
                  )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                      child: Image(image: AssetImage('assets/tailorbook.png'))),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: primaryColor,
                ),
                title: Text('Home'.tr),
                trailing: _trailIcon(),
                onTap: () {
                  Get.back();
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: primaryColor,
                ),
                trailing: _trailIcon(),
                title: Text('New Record'.tr),
                onTap: () {
                  Get.back();
                  AddRecordController _addRecordController =
                  Get.put(AddRecordController());
                  Get.to(() => AddRecord(
                    appbarTitle: "Add New Record",
                    buttonText: "SaveNow".tr,
                  ));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: primaryColor,
                ),
                title: Text("Language".tr),
                trailing: CupertinoSwitch(
                  activeColor: Color(0xff133946),
                  value: _isSelectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      _isSelectedLanguage = value;
                      print("is selected value is : " +
                          _isSelectedLanguage.toString());
                      if (_isSelectedLanguage == false) {
                        _localizationService.changeLocale("English");
                        print("is selected value is false  : " +
                            _isSelectedLanguage.toString());
                      }
                      if (_isSelectedLanguage == true) {
                        _localizationService.changeLocale("اردو");
                        print("is selected value is true : " +
                            _isSelectedLanguage.toString());
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height/2),
                child: Center(child: Text('App Version 1.0.0')),
                // ListTile(
                //   leading: Icon(
                //     Icons.logout,
                //     color: primaryColor,
                //   ),
                //   trailing: _trailIcon(),
                //   title: Text('Sign Out'.tr),
                //   onTap: () {
                //     GetStorage().remove('number');
                //     GetStorage().remove('name');
                //     Get.offAll(() => LoginScreen());
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            AddRecordController _addRecordController =
                Get.put(AddRecordController());
            Get.to(() => AddRecord(
                  appbarTitle: "Add New Record",
                  buttonText: "SaveNow".tr,
                ));
          },
        ),
        persistentFooterButtons: [
          if (_isBannerAdReady.isTrue)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
        ],
        body: StreamBuilder<QuerySnapshot>(
            stream: searchValue.value == "null" ? _usersStream : FirebaseFirestore.instance
                .collection('Users')
                .doc("$number")
                .collection("Data")
                .where("searchKeyword", arrayContains: searchValue.value)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // print("data is " + snapshot.data!.docs[0]["Name"].toString() + searchValue.value);
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Loading"),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                print("search is " + snapshot.data!.docs.toString());
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/nodata.json'),
                      Text(
                        "No Records Found".tr,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  print("data list" +
                      snapshot.data!.docs[index]["Name"].toString());
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title:
                          Text(snapshot.data!.docs[index]["Name"].toString()),
                      subtitle: Text(
                          snapshot.data!.docs[index]["Address"].toString()),
                      trailing: ElevatedButton(
                        child: Text("ViewDetail".tr),
                        style: ElevatedButton.styleFrom(
                            primary: Constants.primaryColor,
                            elevation: 2,
                            shape: StadiumBorder()),
                        onPressed: () {
                          Get.to(() => DetailScreen(
                                recordData: snapshot.data!.docs[index],
                              ));
                        },
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }),
      );
    });
  }

  Widget _trailIcon() {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      color: primaryColor,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_book/Controllers/LoginScreenController.dart';
import 'package:tailor_book/Services/Fire_Store_CRUD.dart';
import 'package:tailor_book/UI%20Screens/Constants.dart';
import 'package:tailor_book/UI%20Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = LoginController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          } // currentFocus.dispose();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Container(
              color: Constants.primaryColor,
              child: Center(
                child: Container(
                  // margin:  EdgeInsets.all(MediaQuery.of(context).size.width/10),
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/splash.png',
                          width: 120,
                          height: 120,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Welcome to ',
                            style: Theme.of(context).textTheme.bodyText2,
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'the',
                              ),
                              TextSpan(text: ' world of\n'),
                              TextSpan(
                                  text: 'Tailor Book',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Let's Start Now",
                          textAlign: TextAlign.left,
                        ),
                        Column(
                          children: [
                            inputField(
                                "Phone Number",
                                "030000000",
                                Icons.phone,
                                loginController.numberController,
                                TextInputType.phone,
                                context),
                            inputField(
                                "Full Name",
                                "Farhan Aslam",
                                Icons.account_circle,
                                loginController.nameController,
                                TextInputType.text,
                                context),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                height: MediaQuery.of(context).size.width / 8,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    if (loginController
                                            .nameController.text.isEmpty ||
                                        loginController
                                            .numberController.text.isEmpty) {
                                      Get.showSnackbar(GetBar(
                                        title: "Error",
                                        // messageText: Text("Fill all Fields", style: TextStyle(color: Colors.white),),
                                        isDismissible: true,
                                        icon: Icon(
                                          Icons.error_outline,
                                          color: Colors.white,
                                        ),
                                        duration: Duration(milliseconds: 1500),
                                        message: "Fill all Fields",
                                      ));
                                    } else {
                                      // Constants.prefs.setInt('number', );
                                      GetStorage().write(
                                          'number',
                                          loginController
                                              .numberController.text);
                                      GetStorage().write('name',
                                          loginController.nameController.text);
                                      Database.registerUser(
                                              userName: loginController
                                                  .nameController.text,
                                              userNumber: loginController
                                                  .numberController.text);
                                    }
                                  },
                                  child: Text("Get Started"),
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Constants.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                          // inputField(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

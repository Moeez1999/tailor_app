import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


const Color primaryColor = Color(0xff133946);

class Constants{
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static const Color primaryColor = Color(0xff133946);
  static const color = const Color(0XFF133946);
  static final storage = () => GetStorage();
  static final detailItems = ["Length","Arm","Teera","Boundary","Shalwar Length","Paincha","Collar Tip","Cuff","Front Pocket","Side Pockets","Shalwar Pocket","Boundary Shape"];


  static setSearchParam(String caseNumber) {
    List<String> caseSearchList = <String>[];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  //Phone Caller Method
  static callNumber(String number) async{
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }


}




ThemeData appThemeData = ThemeData(

    splashColor: Colors.grey,


// Define the default font family.
// fontFamily: 'Georgia',

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 24.0),
      headline6: TextStyle(fontSize: 20.0),
      bodyText2: TextStyle(
        fontSize: 14.0,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Color(0xff000a12)));

inputField(String showText, String showIn, IconData _icon,TextEditingController? _controller,TextInputType _keyboardType,BuildContext context) {

  return Card(
    margin: EdgeInsets.all(12),
    shape: StadiumBorder(),
    shadowColor: Constants.primaryColor,
    elevation: 2,
    child: TextFormField(
      controller: _controller!,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      autofocus: false,
      keyboardType: _keyboardType,
      // onSubmitted: (_) => nextEditableTextFocus(context),
      decoration: InputDecoration(
        prefixIcon: Icon(
          _icon,
          color: Constants.primaryColor,
        ),
        labelText: showText,
        labelStyle: TextStyle(color: Constants.primaryColor),
        hintText: showIn,
        border: InputBorder.none,
      ),
    ),
  );
}


appButton(
  String _label,
  BuildContext context,
) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.width / 8,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(_label),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: Constants.primaryColor,
      ),
    ),
  );
}

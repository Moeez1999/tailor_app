// To parse this JSON data, do
//
//     final addRecordModel = addRecordModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AddRecordModel addRecordModelFromJson(String str) =>
    AddRecordModel.fromJson(json.decode(str));

String addRecordModelToJson(AddRecordModel data) => json.encode(data.toJson());

class AddRecordModel {
  AddRecordModel({
    required this.name,
    required this.number,
    required this.length,
    required this.arm,
    required this.teera,
    required this.boundary,
    required this.shalwarLength,
    required this.cuff,
    required this.address,
    required this.searchKeyword,
    required this.boundaryShape,
    required this.collarTip,
    required this.frontPocket,
    required this.shalwarPocket,
    required this.sidePockets,
    required this.paincha,
  });

  String name;
  String number;
  String length;
  String arm;
  String teera;
  String boundary;
  String shalwarLength;
  String cuff;
  String? docId;
  String address;
  Timestamp? createdAt;
  List searchKeyword;
  String collarTip;
  String frontPocket;
  String sidePockets;
  String shalwarPocket;
  String boundaryShape;
  String paincha;

  factory AddRecordModel.fromJson(Map<String, dynamic> json) => AddRecordModel(
      name: json["Name"],
      number: json["Number"],
      length: json["Length"],
      arm: json["Arm"],
      boundaryShape: json["boundaryShape"],
      teera: json["Teera"],
      collarTip: json["collarTip"],
      boundary: json["boundary"],
      frontPocket: json["frontPocket"],
      shalwarLength: json["Shalwar Length"],
      cuff: json["Cuff "],
      shalwarPocket: json["shalwarPocket"],
      sidePockets: json["sidePockets"],
      address: json["Address"],
      searchKeyword: json["searchKeyword"],
      paincha: json['paincha']);

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Number": number,
        "Length": length,
        "Arm": arm,
        "Boundary Shape": boundaryShape,
        "Teera": teera,
        "Collar Tip": collarTip,
        "Boundary": boundary,
        "Front Pocket": frontPocket,
        "Shalwar Length": shalwarLength,
        "Cuff": cuff,
        "Shalwar Pocket": shalwarPocket,
        "Side Pockets": sidePockets,
        "doc_Id": "${docId!}",
        "Address": address,
        "createdAt": createdAt!,
        "searchKeyword": searchKeyword,
        "Paincha": paincha
      };
}

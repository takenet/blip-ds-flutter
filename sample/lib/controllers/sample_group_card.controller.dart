import 'dart:convert';

import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleGroupCardController {
  Future<List<DSMessageItemModel>> getMessages() async {
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString("assets/messages.json");
    final jsonResult = jsonDecode(data);

    final messages = (jsonResult as List)
        .map(
          (doc) => DSMessageItemModel.fromJson(
            {
              "id": doc["id"],
              "date": doc["date"],
              "displayDate": doc["displayDate"],
              "align": doc["align"],
              "type": doc["type"],
              "status": doc["status"],
              "content": doc["content"],
              "customerName": "User Name",
            },
          ),
        )
        .toList();

    return messages.reversed.toList();
  }
}

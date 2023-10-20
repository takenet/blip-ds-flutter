import 'package:get/get.dart';

import '../../models/ds_message_item.model.dart';

class DSReplyController extends GetxController {
  final List<DSMessageItemModel> messages = [];

  void addMessages(List<DSMessageItemModel> newMessages) {
    messages.addAll(newMessages);
  }

  DSMessageItemModel? getMessageById(String id) {
    return messages.firstWhereOrNull((element) => element.id == id);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameEditingController;
  var username = ''.obs;
  var isEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameEditingController = TextEditingController();
  }

  void onFieldChange(String value) {
    /// Push the text field value to the username variable
    username = RxString(value);

    /// Conditionally set the value of isEnabled to true or false
    username.value.length > 2
        ? isEnabled = RxBool(true)
        : isEnabled = RxBool(false);

    /// Rebuild the GetBuilder
    update();
  }

  void clearUsernameField() {
    /// Set the isEnable back to false
    isEnabled = RxBool(false);

    /// Clear the text field and hide the keyboard
    usernameEditingController.clear();
    FocusManager.instance.primaryFocus.unfocus();

    /// Rebuild the GetBuilder
    update();
  }
}

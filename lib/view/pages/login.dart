import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/controller/login_controller.dart';
import 'package:flutter_ble_messenger/controller/settings_controller.dart';
import 'package:flutter_ble_messenger/view/animations/fade.dart';
import 'package:flutter_ble_messenger/view/pages/devices.dart';
import 'package:flutter_ble_messenger/view/widgets/common/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                    top: -50,
                    left: 0,
                    child: Fade(
                      1,
                      Container(
                        width: width,
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/one.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  top: -100,
                  left: 0,
                  child: Fade(
                    1,
                    Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -150,
                  left: 0,
                  child: Fade(
                    1,
                    Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Fade(
                        1.2,
                        Text(
                          'Chable!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Fade(
                        1.5,
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: 20),
                                  onChanged: loginController.onFieldChange,
                                  keyboardType: TextInputType.text,
                                  onSubmitted: (string) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();

                                    if (settingsController
                                            .isLocationPermitted.value &&
                                        settingsController
                                            .isLocationServicesGranted.value) {
                                      if (loginController
                                                  .username.value.length >
                                              2 &&
                                          loginController.isEnabled.value) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              child: Devices(),
                                              type: PageTransitionType.fade),
                                        );
                                      } else {
                                        FocusManager.instance.primaryFocus
                                            .unfocus();
                                      }
                                    } else {
                                      settingsController.checkLocation(context);
                                    }
                                  },
                                  controller:
                                      loginController.usernameEditingController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.8),
                                      fontSize: 20,
                                    ),
                                    hintText: 'What is your Nickname?',
                                    suffixIcon: IconButton(
                                      onPressed:
                                          loginController.clearUsernameField,
                                      icon: Icon(
                                        Icons.clear,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      GetBuilder<LoginController>(
                        builder: (controller) => controller.isEnabled.value
                            ? Fade(
                                1.5,
                                Center(
                                  child: customElevatedButton(
                                    label: "Search active users",
                                    context: context,
                                    fontSize: 20,
                                    callback: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();

                                      if (settingsController
                                              .isLocationPermitted.value &&
                                          settingsController
                                              .isLocationServicesGranted
                                              .value) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              child: Devices(),
                                              type: PageTransitionType.fade),
                                        );
                                      } else {
                                        settingsController
                                            .checkLocation(context);
                                      }
                                    },
                                  ),
                                ),
                              )
                            : Fade(
                                1.8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enter your Nickname to continue.\nYour Nickname must be at least 3 characters long.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

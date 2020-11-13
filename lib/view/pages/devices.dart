import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/controller/dates_controller.dart';
import 'package:flutter_ble_messenger/controller/devices_controller.dart';
import 'package:flutter_ble_messenger/view/animations/fade.dart';
import 'package:flutter_ble_messenger/view/widgets/common/sliver_app_bar_title.dart';
import 'package:flutter_ble_messenger/view/widgets/devices/device_card.dart';
import 'package:get/get.dart';

class Devices extends StatelessWidget {
  final greetingsController = Get.put(DatesController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title:
                        SliverAppBarTitle(child: Text('Nearby Active Users')),
                    centerTitle: true,
                    pinned: true,
                    floating: false,
                    snap: false,
                    expandedHeight: height / 3,
                    automaticallyImplyLeading: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
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
                          Positioned(
                            top: -200,
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
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GetX<DevicesController>(
                                    init: DevicesController(context),
                                    builder: (controller) {
                                      return Fade(
                                        1.2,
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${controller.datesController.greeting.value},',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text:
                                                    '\n${controller.username}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  Fade(
                                    1.8,
                                    Text(
                                      'Here are the list of active users nearby.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        height: 1.4,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: MessengerBody(),
        ),
      ),
    );
  }
}

class MessengerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<DevicesController>(
      init: DevicesController(context),
      builder: (controller) {
        return controller.devices.isNotEmpty
            ? ListView.builder(
                itemCount: controller.devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return DeviceCard(
                    device: controller.devices[index],
                    username: controller.username.value,
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).buttonColor),
                ),
              );
      },
    );
  }
}

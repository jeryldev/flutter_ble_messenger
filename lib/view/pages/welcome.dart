import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/view/animations/fade.dart';
import 'package:flutter_ble_messenger/view/pages/login.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _widthController.forward();
              }
            },
          );

    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300,
    ).animate(_widthController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _positionController.forward();
          }
        },
      );

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 220,
    ).animate(_positionController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              hideIcon = true;
            });
            _scale2Controller.forward();
          }
        },
      );

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32,
    ).animate(_scale2Controller)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.push(
              context,
              PageTransition(child: Login(), type: PageTransitionType.fade),
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(3, 9, 23, 1),
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
                padding: EdgeInsets.all((20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Fade(
                      1,
                      Text(
                        'Welcome to Chable!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Fade(
                      1.3,
                      Text(
                        'Chable! is an android-based chat application prototype which I built using Flutter and Nearby Connections API plugin.\nUnlike most chat applications, Chable! utilizes Bluetooth, Wi-Fi, and Location Services in mobile phones to create a fully-offline peer-to-peer network.\nThis app allows users to easily discover, connect to, and exchange data with nearby devices in real-time, regardless of network connectivity.\nI created this app as part of the requirements in CMSC 205: Data Communications and Networking class at the University of the Philippines Open University (UPOU).',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          height: 1.4,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Fade(
                      1.6,
                      AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _widthController,
                              builder: (context, child) => Container(
                                width: _widthAnimation.value,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // color: Colors.blue.withOpacity(0.4),
                                  color: Theme.of(context)
                                      .buttonColor
                                      .withOpacity(0.4),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    _scaleController.forward();
                                  },
                                  child: Stack(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) =>
                                                Transform.scale(
                                              scale: _scale2Animation.value,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  // color: Colors.blue,
                                                  color: Theme.of(context)
                                                      .buttonColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: hideIcon == false
                                                    ? Icon(
                                                        Icons
                                                            .arrow_forward_rounded,
                                                        // color: Colors.white,
                                                        color: Colors.black54,
                                                      )
                                                    : Container(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

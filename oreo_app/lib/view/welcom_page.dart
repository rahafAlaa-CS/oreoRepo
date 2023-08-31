import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oreo_app/view/product_page.dart';

import '../helpers/check_internet.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  NetworkController networkController = NetworkController();
  bool noInternet = false;
  @override
  void initState() {
    setState(() {
      checkInternetConnectio();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/Brown World Chocolate Day Flyer 1.png',
              )),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.25, 0.9],
              colors: [Color(0xffBAB4AE), Color(0xff003C7B)])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to choc",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontFamily: "CrimsonText-Regular",
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.005,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Cookies.png'),
                  maxRadius: 10,
                  minRadius: 10,
                ),
              ],
            ),
            Text(
              ".",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontFamily: "CrimsonText-Regular",
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: noInternet
              ? Column(
                  children: [
                    Text(
                      'Please check your internet connection',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => WelcomPage()));
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12),
                      color: Color(0xffBAB4AE),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        'Try again',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "CrimsonText-Regular",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ]),
    );
  }

  Future<void> checkInternetConnectio() async {
    await {
      Future.delayed(Duration(seconds: 1), () async {
        // check internet
        networkController.onInit();
        await Future.delayed(const Duration(seconds: 1));

        if (networkController.connectionType != 0) {
          setState(() {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => ProductPage()));
          });
        } else {
          setState(() => noInternet = true);
        }
      })
    };
  }
}

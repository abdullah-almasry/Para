import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:para_new/Utils/APIs.dart';
import 'package:toast/toast.dart';

import '../Helpers/colors.dart';
import '../Pages/navigationPages/MyDates.dart';
import '../Pages/navigationPages/Profile.dart';
import '../Pages/navigationPages/Search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;

  Widget body() {
    switch (selectedPage) {
      case 0:
        return new Profile();
        break;
      case 1:
        return new Search();
        break;
      case 2:
        return new MyDates();
        break;
    }
    return Container();
  }

  void openMail(BuildContext context) {
    try {
      AppAvailability.launchApp(
              Platform.isIOS ? "message://" : "com.google.android.gm")
          .then((_) {
        print("App Email launched!");
      }).catchError((err) {
        Toast.show("App Email not found!", context);
        print(err);
      });
    } catch (e) {
      Toast.show("Email App not found!", context);
    }
  }

  @override
  void initState() {
    super.initState();
    APIs.getCommission();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => openMail(context),
          child: Icon(Icons.email),
        ),
        body: this.body(),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: selectedPage,
          iconSize: 25,
          unselectedItemColor: UIColors.ICON_TEXT_COLOR,
          selectedItemColor: UIColors.SECONDARY_COLOR,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  'profile',
                  style: TextStyle(
                      color: UIColors.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold),
                ).tr(context: context)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  'search',
                  style: TextStyle(
                      color: UIColors.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold),
                ).tr(context: context)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text(
                  'appointments',
                  style: TextStyle(
                      color: UIColors.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold),
                ).tr(context: context)),
          ],
          onTap: (index) {
            setState(() {
              this.selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}

import 'package:booking_car/Screens/Home/home_screen.dart';
import 'package:booking_car/Screens/contract_group/contract.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:booking_car/screens/analysis/analysis_screen.dart';
import 'package:booking_car/screens/calendar/calendar_screen.dart';
import 'package:booking_car/screens/custom_drawer/drawer_user_controller.dart';
import 'package:booking_car/screens/custom_drawer/home_drawer.dart';
import 'package:booking_car/screens/maintanence/maintanence.dart';
import 'package:booking_car/screens/profile/profile_screen.dart';
import 'package:booking_car/screens/settings/settings_screen.dart';
import 'package:booking_car/screens/registry/registry.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.CarManagement;
    screenView = const HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.55,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.CarManagement:
          setState(() {
            screenView = HomeScreen();
          });
          break;
        case DrawerIndex.Contract:
          setState(() {
            screenView = Contract();
          });
          break;
        case DrawerIndex.Maintenance:
          setState(() {
            screenView = Maintenance();
          });
          break;
        case DrawerIndex.Registry:
          setState(() {
            screenView = RegistryScreen();
          });
          break;

        default:
          break;
      }
    }
  }
}

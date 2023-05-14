import 'package:booking_car/Screens/Home/home_screen.dart';
import 'package:booking_car/Screens/contract_group/contract.dart';
import 'package:booking_car/screens/car_detail/car_detail.dart';
import 'package:booking_car/screens/contractGroup/contract_progress.dart';
import 'package:booking_car/screens/contractGroup/step5_receive_contract/receive_contract.dart';
import 'package:booking_car/screens/maintanence/maintenance_history.dart';
import 'package:booking_car/screens/onboding/onboding_screen.dart';
import 'package:flutter/material.dart';
import 'router_constant.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => OnbodingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case carDetailPage:
        {
          final Map args = settings.arguments as Map;

          final int id = args['id'];
          final Function reload = args['reload'];
          return MaterialPageRoute(
            builder: (_) => CarDetail(
              id: id,
              reload: reload,
            ),
          );
        }

      case contractGroup:
        return MaterialPageRoute(builder: (_) => Contract());
      case contractProgress:
        final int id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ProgressTracking(
                  contractGroupId: id,
                ));
      case maintenanceHistory:
        final int id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => MaintenanceList(carId: id));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

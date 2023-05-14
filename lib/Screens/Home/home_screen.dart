import 'dart:async';
import 'dart:convert';

import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_info/car_info_cubit.dart';
import 'package:booking_car/blocs/cubit/user/user_cubit.dart';
import 'package:booking_car/components/appbar.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:booking_car/config.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:booking_car/screens/home/components/list_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../components/filter_search.dart';

int page = 1;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  var getResult = 'QR';
  bool multiple = true;
  late final PageController pageController;
  Future<void> _loadData(int page) async {
    context.read<CarCubit>().getAllCar(page, 10);
  }

  Future<void> _loadInfo() async {
    if (context.read<InfoCubit>().state.carStatus.isEmpty) {
      context.read<InfoCubit>().getInfo(STATUS);
    }
    if (context.read<InfoCubit>().state.carMake.isEmpty) {
      context.read<InfoCubit>().getCarMake(CAR_MAKE);
    }
  }

  Future<void> _getUser() async {
    String? email = await storage.read(key: 'email');
    print('email 12: $email');
    if (email != null) {
      context.read<UserCubit>().getUser(email);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      page = 1;
    });
    await _loadData(page);
  }

  Future<void> _loadMore() async {
    page++;
    context.read<CarCubit>().getAllCar(page, 10);
    // await _loadData(page);
  }

  @override
  void initState() {
    _loadData(1);
    _loadInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showWaringDialog(BuildContext context, String content) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Đóng"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo"),
      content: Text(content, style: TextStyle(fontSize: 18)),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  void scanQR() async {
    try {
      String parkinglotID = await storage.read(key: 'parkinglotID') ?? "-1";
      final qrCode =
          await FlutterBarcodeScanner.scanBarcode('#2f7cf7', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        getResult = qrCode;
      });
      if (getResult == '-1') {
        return;
      }
      Map<String, dynamic> jsonMap = jsonDecode(getResult);
      int carId = jsonMap['carId'];
      int parkingID = jsonMap['parkingLot'];
      int parsed = int.parse(parkinglotID);
      print('parsed $parsed');
      if (parsed == parkingID) {
        Navigator.pushNamed(context, carDetailPage,
            arguments: {'id': carId, "reload": () => _refresh});
      } else {
        showWaringDialog(context, 'Bạn không có quyền truy cập vào xe này');
      }

      debugPrint('QR Code: $qrCode');
    } on PlatformException {
      debugPrint('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('Scan QR');
            scanQR();
          },
          backgroundColor: Color(0xFF4dabf7),
          child: const Icon(Icons.qr_code_outlined)),
      // resizeToAvoidBottomInset: false,
      // drawer: SideBar()

      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomAppBar(isHomeScreen: true),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SearchBar(),
                  CustomTextField(
                    onChangedString: context.read<CarCubit>().onChangeSearchString,
                    title: 'Tìm kiếm',
                    hintText: 'Tìm theo biển số xe',
                    keyboardType: TextInputType.text,
                    endIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  FilterSearch(),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 4)),
            Expanded(
              child: CarListView(
                onRefresh: _refresh,
                onLoadingMore: _loadMore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

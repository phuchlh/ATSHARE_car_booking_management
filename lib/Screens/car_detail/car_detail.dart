// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_expense/car_expense_cubit.dart';
import 'package:booking_car/blocs/cubit/car_schedule/car_schedule_cubit.dart';
import 'package:booking_car/components/back_to_previous_page.dart';
import 'package:booking_car/components/cicular_loading.dart';
import 'package:booking_car/components/error_dialog.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:booking_car/components/spacing_line.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/car_expense.dart';
import 'package:booking_car/models/car_expense_post.dart';
import 'package:booking_car/models/car_schedule_model.dart';
import 'package:booking_car/models/car_schedule_post.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:booking_car/screens/car_detail/components/car_information.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'components/slide_image.dart';

class CarDetail extends StatefulWidget {
  const CarDetail({super.key, required this.id, this.reload});
  final int id;
  final Function? reload;

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  late File? frontImage;
  late File? backImage;
  late File? leftImage;
  late File? rightImage;
  late File? otherImage;
  late List<File?> listImage;

  Future _loadById(int id) async {
    await context.read<CarCubit>().getCarById(id);
  }

  Future<void> _loadExpense(int carID) async {
    await context.read<CarExpenseCubit>().getCarExpense(carID);
  }

  Future<void> _loadSchedule(int carID) async {
    await context.read<CarScheduleCubit>().getCarSchedule(carID);
  }

  // Future<void> _createSchedule(CarSchedulePost carSchedulePost, Car carObj) async {
  //   context.read<CarScheduleCubit>().createCarSchedule(carSchedulePost);
  //   context.read<CarScheduleCubit>().stream.listen((event) {
  //     if (event.status == CarScheduleStatus.succcess) {
  //       EasyLoading.showSuccess('Tạo lịch thành công');
  //       context.read<CarCubit>().updateCarStatus(widget.id, carObj);
  //       if (mounted) {
  //         Navigator.pop(context);
  //       }
  //       EasyLoading.dismiss();
  //     } else if (event.status == CarScheduleStatus.error) {
  //       EasyLoading.showError('Thất bại, vui lòng thử lại sau');
  //     }
  //   });

  //   await _loadById(widget.id);
  // }

  Future _refresh() async {
    await _loadById(widget.id);
  }

  // Future<void> _updateCar(int carID, Car carObj) async {
  //   print(carObj.toJson());
  //   context.read<CarCubit>().updateCarImage(carID, carObj);
  //   context.read<CarCubit>().stream.listen((event) {
  //     if (event.status == CarStatus.succcess) {
  //       EasyLoading.showSuccess('Cập nhật thành công');
  //       EasyLoading.dismiss();
  //     } else if (event.status == CarStatus.error) {
  //       EasyLoading.showError('Thất bại, vui lòng thử lại sau');
  //       EasyLoading.dismiss();
  //     }
  //   });
  // }

  // Future<void> initCarLoading(int carID) async {
  //   await context.read<CarCubit>().getCarById(carID);
  //   context.read<CarScheduleCubit>().getCarSchedule(carID);
  //   // ignore: use_build_context_synchronously
  //   context.read<CarCubit>().stream.listen((event) {
  //     if (event.status == CarStatus.succcess) {
  //       context.read<CarExpenseCubit>().getCarExpense(carID);
  //     }
  //   });
  //   // await _loadingCompleter.future;
  //   // await context.read<CarCubit>().getCarSchedule(carID);
  //   // _loadingCompleter.complete();
  // }

  Future<List<String>> _uploadFile(List<File> listImage) async {
    List<String> downloadURLs = [];
    try {
      final List<Future<String>> uploadTasks = [];
      for (final file in listImage) {
        final _storage = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png}');

        final uploadTask =
            _storage.putFile(file).then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
        uploadTasks.add(uploadTask);
      }
      downloadURLs = await Future.wait(uploadTasks);
      return downloadURLs;
    } on PlatformException catch (e) {
      print(e);
    }
    return downloadURLs;
  }

  final Map<int, String> _imageWithDescription = {
    0: 'ảnh mặt trước',
    1: 'ảnh mặt sau',
    2: 'ảnh bên phải',
    3: 'ảnh bên trái',
    4: 'ảnh nội thất',
  };
  @override
  // initCarLoading(widget.id);
  void initState() {
    _loadById(widget.id);
    _loadExpense(widget.id);
    _loadSchedule(widget.id);
    frontImage = null;
    backImage = null;
    leftImage = null;
    rightImage = null;
    otherImage = null;
    listImage = [frontImage, backImage, leftImage, rightImage, otherImage];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appBarColor,
      //   elevation: 0.0,
      // ),
      /*
      FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, maintenanceHistory, arguments: widget.id);
        },
        label: const Text('Bảo dưỡng'),
        icon: const Icon(Icons.engineering_outlined),
        backgroundColor: Color(0xFF4dabf7),
      ),
       */
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: primaryColor,
        overlayOpacity: 0,
        spaceBetweenChildren: 12,
        closeManually: false,
        spacing: 12,
        children: [
          SpeedDialChild(
            child: Icon(Icons.check),
            label: 'Tạo chi phí',
            onTap: () async {
              createCarExpense(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.engineering_outlined),
            label: 'Tạo lịch bảo dưỡng',
            onTap: () async {
              createCarSchedule(context, widget.id);
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CarCubit, CarState>(
          builder: ((context, state) {
            switch (state.status) {
              case CarStatus.error:
                return DialogConfirm(
                  title: 'Đã có lỗi',
                  content: 'Phát sinh lỗi trong quá trình xử lý, vui lòng thử lại trong giây lát',
                );
              case CarStatus.succcess:
                return CarDetailSuccess(state.car!);
              case CarStatus.loading:
                return Center(
                  child: CircularLoading(),
                );
              default:
                return Center(
                  child: CircularLoading(),
                );
            }
          }),
        ),
      ),
    );
  }

  Future<DateTime> _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(3333),
    );
    return pickedDate ?? DateTime.now();
  }

  String checkUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {
      return ERROR_PHOTO;
    }
  }

  Future<List<File>> _takePicture() async {
    final List<File> imageFile = [];

    for (final value in _imageWithDescription.values) {
      Fluttertoast.showToast(
        msg: 'Chụp ảnh $value',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
      );
      final XFile? picked = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxHeight: 1920, maxWidth: 1080);
      if (picked == null) return [];
      imageFile.add(File(picked.path));
    }
    return imageFile;
  }

  String _parseDate(String date) {
    var dateParse = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    return dateParse.toString();
  }

  Widget CarDetailSuccess(Car car) {
    String registryDeadLine = car.registrationDeadline ?? DateTime.now().toString();
    final deadline = DateFormat('dd-MM-yyyy').format(DateTime.parse(registryDeadLine));
    String frontImg = car.frontImg ?? "";
    String backImg = car.backImg ?? "";
    String leftImg = car.leftImg ?? "";
    String rightImg = car.rightImg ?? "";
    String otherImg = car.ortherImg ?? "";
    var f = NumberFormat('#,###', 'en_US');
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: Stack(
                  children: [
                    SlideImage(
                      frontImg: checkUrl(frontImg),
                      backImg: checkUrl(backImg),
                      leftImg: checkUrl(leftImg),
                      rightImg: checkUrl(rightImg),
                      otherImg: checkUrl(otherImg),
                    ),
                    PreviousPage(),
                    Container(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black45,
                            child: IconButton(
                              onPressed: () async {
                                listImage = await _takePicture();
                                if (listImage.isEmpty) return;
                                setState(() {
                                  frontImage = listImage[0];
                                  backImage = listImage[1];
                                  leftImage = listImage[2];
                                  rightImage = listImage[3];
                                  otherImage = listImage[4];
                                });
                                showBottom(listImage, car);
                              },
                              icon: Icon(Icons.camera_alt_outlined),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black45,
                            child: IconButton(
                              onPressed: () {
                                showBottom(listImage, car);
                              },
                              icon: Icon(Icons.edit_outlined),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TabBar(
              tabs: const [
                Tab(text: 'Thông tin xe'),
                Tab(text: 'Chi phí xe'),
                Tab(text: 'Lịch sử hoạt động'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // tab 1
                  carInfo(context, car, f),
                  // tab 2
                  BlocBuilder<CarExpenseCubit, CarExpenseState>(
                    builder: (context, state) {
                      final listExpense = state.listExpense;
                      if (listExpense.isEmpty) {
                        return Center(
                          child: Text('Xe hiện tại chưa có chi phí'),
                        );
                      } else {
                        return carExpense(context, listExpense, f);
                      }
                    },
                  ),
                  BlocBuilder<CarScheduleCubit, CarScheduleState>(
                    builder: (context, state) {
                      final listSchedules = state.listSchedule;
                      if (listSchedules.isEmpty) {
                        return Center(
                          child: Text('Xe hiện tại chưa có lịch sử hoạt động'),
                        );
                      } else {
                        return carSchedule(context, listSchedules);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowData(BuildContext context, String title, String content, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(icon),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
      ],
    );
  }

  Widget carSchedule(BuildContext context, List<CarScheduleModel> carSchedule) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final schedule = carSchedule[index];
                  final start = schedule.dateStart ?? DateTime.now().toString();
                  final end = schedule.dateEnd ?? DateTime.now().toString();
                  final startDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(start));
                  final endDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                  return GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            child: Text('Xóa lịch sử hoạt động'),
                            height: 300,
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                      ),
                      height: MediaQuery.of(context).size.height * .13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          rowData(context, 'Ngày bắt đầu:', startDate, Icons.article_outlined),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          rowData(context, 'Ngày kết thúc:', endDate, Icons.date_range),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          rowData(context, 'Trạng thái:', schedule.carStatusName ?? 'Chưa xác định',
                              Icons.article_outlined),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 10,
                    ),
                itemCount: carSchedule.length),
          ),
        ],
      ),
    );
  }

  Widget carExpense(BuildContext context, List<CarExpense> carExpense, NumberFormat f) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 10,
              ),
              itemCount: carExpense.length,
              itemBuilder: (context, index) {
                final expense = carExpense[index];
                String dayExpense = expense.day ?? DateTime.now().toString();
                final dayEx = DateFormat('dd-MM-yyyy').format(DateTime.parse(dayExpense));

                return Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rowData(
                          context, 'Nội dung:', expense.title.toString(), Icons.article_outlined),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      rowData(context, 'Ngày:', dayEx, Icons.date_range),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      rowData(context, 'Số tiền:', '${f.format(expense.amount)} đ',
                          Icons.article_outlined),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }

  Widget carInfo(BuildContext context, Car car, NumberFormat f) {
    String registryDeadLine = car.registrationDeadline ?? DateTime.now().toString();
    final deadline = DateFormat('dd-MM-yyyy').format(DateTime.parse(registryDeadLine));
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: 360,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              leading: Icon(Icons.edit_note_outlined),
              title: Text(
                'THÔNG TIN XE',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(Icons.article_outlined),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Tên xe:',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${car.modelName}',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(Icons.directions_car_filled_outlined),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Hãng xe:',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${car.makeName}',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(Icons.battery_charging_full_outlined),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Nhiên liệu:',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${car.carFuel}',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(Icons.local_parking),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Bãi xe:',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${car.parkingLotName}',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: [
                        Spacing(
                          title: 'Đời xe',
                          pdleft: 20,
                          icon: Icons.calendar_today_outlined,
                          text: car.modelYear!.toString(),
                          sizeIcon: 0,
                          isCarDetailPage: true,
                        ),
                        Spacing(
                          title: 'Số chỗ:',
                          pdleft: 20,
                          icon: Icons.flight_class_outlined,
                          text: car.seatNumber!.toString(),
                          sizeIcon: 0,
                          isCarDetailPage: true,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      children: [
                        Spacing(
                          title: 'Động cơ:',
                          pdleft: 20,
                          icon: Icons.flag_outlined,
                          text: car.trimName!,
                          sizeIcon: 0,
                          isCarDetailPage: true,
                        ),
                        Spacing(
                          title: 'Màu xe:',
                          pdleft: 20,
                          icon: Icons.color_lens_outlined,
                          text: car.carColor!,
                          sizeIcon: 0,
                          isCarDetailPage: true,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Biển biểm soát',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        SizedBox(
                          width: 140,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              // car.carLicensePlates!,
                              '${car.carLicensePlates!.substring(0, 3)}-${car.carLicensePlates!.substring(3)}',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 20),
                      title: Text(
                        'Mô tả:',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        car.carDescription!,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          CarInformation(
            title: 'THÔNG TIN THUÊ XE',
            icon: Icons.edit_note_outlined,
            pdBot: 10,
            pdLeft: 20,
            mapItem: {
              'Ngày thường:': '${f.format(car.priceForNormalDay?.toInt() ?? 0)} VND',
              'Cuối tuần:': "${f.format(car.priceForWeekendDay?.toInt() ?? 0)} VND",
              'Tháng:': '${f.format(car.priceForMonth?.toInt() ?? 0)} km',
              'Giới hạn số km:': '${f.format(car.limitedKmForMonth?.toInt() ?? 0)} km',
              'Phí vượt:': '${f.format(car.overLimitedMileage?.toInt() ?? 0)} VND/km',
              'Giới hạn trong tháng:': '${f.format(car.limitedKmForMonth?.toInt() ?? 0)} km',
              'Tỉ lệ ăn chia:': '${car.ownerSlitRatio?.toDouble() ?? 0} %',
              'Hạn cuối đăng kiểm:': deadline,
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          CarInformation(
            title: 'HIỆN TRẠNG XE',
            icon: Icons.edit_note_outlined,
            pdBot: 10,
            pdLeft: 20,
            mapItem: {
              'Số đồng hồ hiện tại:': '${f.format(car.speedometerNumber?.toInt() ?? 0)} km',
              'Mức nhiên liệu hiện tại:': '${car.fuelPercent?.toInt() ?? 0}%',
              'Phí ETC hiện tại:': '${f.format(car.currentEtcAmount?.toInt() ?? 0)} VND',
              'Trạng thái:': car.carStatus!.toString(),
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          CarInformation(
            title: 'THÔNG TIN CHỦ XE',
            icon: Icons.edit_note_outlined,
            pdBot: 10,
            pdLeft: 20,
            mapItem: {
              'Tên chủ xe:': car.carOwnerName!,
              'Phương thức cho thuê:': car.rentalMethod!.toString(),
              'Đồng hồ km khi nhận:': '${f.format(car.speedometerNumberReceive?.toInt() ?? 0)} km',
              'Km giới hạn cho tháng:':
                  '${f.format(car.limitedKmForMonthReceive?.toInt() ?? 0)} km',
              'Vượt quá số km giới hạn:':
                  '${f.format(car.overLimitedMileageReceive?.toInt() ?? 0)} VND/km',
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }

  Future<void> createCarSchedule(BuildContext context, int carID) async {
    DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    DateTime dateFrom = DateTime.now();
    String fromParsed = '';
    String toParsed = '';
    String fromDisplay = '';
    String toDisplay = '';
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: 250,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    'Tạo lịch bảo dưỡng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ngày bắt đầu:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final DateTimeRange? dateTimeRange = await showDateRangePicker(
                                context: context,
                                // initialDate: DateTime.now(),
                                // currentDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000),
                                builder: (context, child) {
                                  return Theme(
                                    data: themeData,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: 350.0,
                                            maxHeight: 500.0,
                                          ),
                                          child: child,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (dateTimeRange != null) {
                                setState(() {
                                  dateRange = dateTimeRange;
                                  fromDisplay = _parseDate(dateRange.start.toString());
                                  toDisplay = _parseDate(dateRange.end.toString());
                                  fromParsed = dateRange.start.toIso8601String();
                                  toParsed = dateRange.end.toIso8601String();
                                });
                              }
                            },
                            child: Text(
                              fromDisplay == '' ? 'Chọn ngày ' : fromDisplay.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ngày kết thúc:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final DateTimeRange? dateTimeRange = await showDateRangePicker(
                                context: context,
                                // initialDate: DateTime.now(),
                                // currentDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000),
                                builder: (context, child) {
                                  return Theme(
                                    data: themeData,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: 350.0,
                                            maxHeight: 500.0,
                                          ),
                                          child: child,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (dateTimeRange != null) {
                                setState(() {
                                  dateRange = dateTimeRange;
                                  fromDisplay = _parseDate(dateRange.start.toString());
                                  toDisplay = _parseDate(dateRange.end.toString());
                                  fromParsed = dateRange.start.toIso8601String();
                                  toParsed = dateRange.end.toIso8601String();
                                });
                              }
                            },
                            child: Text(
                              toDisplay == '' ? 'Chọn ngày ' : toDisplay.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Lưu ý: Bạn cần phải lựa ngày bắt đầu và kết thúc trước khi tạo lịch bảo dưỡng',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      CarSchedulePost carSchedule = CarSchedulePost(
                        carId: carID,
                        dateStart: fromParsed,
                        dateEnd: toParsed,
                        carStatusId: 6,
                      );
                      debugPrint('json carSchedule: ${carSchedule.toJson()}');
                      Car carObj = Car(
                        id: carID,
                        carStatusId: 6,
                      );
                      CarCubit cubit = context.read<CarCubit>();
                      CarScheduleCubit scheduleCubit = context.read<CarScheduleCubit>();
                      await scheduleCubit.createCarSchedule(carSchedule);
                      await cubit.updateCarStatus(widget.id, carObj);
                      // if (scheduleCubit.state.status == CarScheduleStatus.succcess &&
                      //     cubit.state.status == CarStatus.succcess) {
                      //   EasyLoading.showSuccess('Tạo lịch thành công');
                      //   Navigator.pop(context);
                      // }

                      _loadById(widget.id);
                      _loadExpense(widget.id);
                      _loadSchedule(widget.id);
                      // _createSchedule(carSchedule, carObj);
                    },
                    child: Text('Cập nhật trạng thái'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> createCarExpense(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    String datePick = "";
    String datePickParsed = "";
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      'Tạo chi phí',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      title: 'Nội dung',
                      onChangedString: (p0) {
                        context.read<CarExpenseCubit>().onChangeTitleExpense(p0);
                      },
                    ),
                    CustomTextField(
                      endIcon: Text(
                        "đ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      title: 'Số tiền',
                      onChangedString: (p0) {
                        context.read<CarExpenseCubit>().onChangeAmountExpense(p0);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ngày bắt đầu:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final DateTime? dateTimePicked = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              lastDate: DateTime(3000),
                              builder: (context, child) {
                                return Theme(
                                  data: themeData,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: 350.0,
                                          maxHeight: 500.0,
                                        ),
                                        child: child,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            if (dateTimePicked != null) {
                              setState(() {
                                dateTime = dateTimePicked;
                                datePick = _parseDate(dateTime.toString());
                                datePickParsed = dateTime.toIso8601String();
                              });
                            }
                          },
                          child: Text(
                            datePick == '' ? 'Chọn ngày ' : datePick.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'Đang tạo chi phí');
                        final carID = widget.id;
                        CarCubit carCubit = context.read<CarCubit>();
                        CarExpenseCubit cubit = context.read<CarExpenseCubit>();
                        final title = cubit.state.title;
                        final amount = cubit.state.amount;
                        CarExpensePost carExpensePost = CarExpensePost(
                          carId: carID,
                          title: title,
                          amount: amount,
                          day: datePickParsed,
                        );
                        Car carObj = Car(
                          id: carID,
                          carStatusId: 2,
                        );
                        await cubit.postCarExpense(carExpensePost);
                        await carCubit.updateCarStatus(carID, carObj);
                        debugPrint('json carSchedule: ${carExpensePost.toJson()}');
                        _loadById(widget.id);
                        _loadExpense(widget.id);
                        _loadSchedule(widget.id);
                        EasyLoading.showSuccess('Đang tạo chi phí');
                        EasyLoading.dismiss();
                        // _createSchedule(carSchedule, carObj);
                      },
                      child: Text('Cập nhật trạng thái'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showBottom(List<File?> imageList, Car car) async {
    File? front = imageList[0];
    File? back = imageList[1];
    File? left = imageList[2];
    File? right = imageList[3];
    File? other = imageList[4];
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 620,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: front == null
                            ? Icon(Icons.error_outline)
                            : Image.file(
                                front,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Text("Mặt trước"),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: back == null
                            ? Icon(Icons.error_outline)
                            : Image.file(
                                back,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Text("Mặt sau"),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: left == null
                            ? Icon(Icons.error_outline)
                            : Image.file(
                                left,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Text("Mặt trái"),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: right == null
                            ? Icon(Icons.error_outline)
                            : Image.file(
                                right,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Text("Mặt phải"),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: other == null
                            ? Icon(Icons.error_outline)
                            : Image.file(
                                other,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Text("Nội thất"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(251, 255, 255, 255),
                      foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: const Text('Hủy bỏ'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(123, 19, 19, 19),
                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: const Text('Cập nhật '),
                    onPressed: () async {
                      if (imageList.isEmpty) {
                        return;
                      }
                      EasyLoading.show(status: 'Đang cập nhật ...');
                      final List<String> downloadUrls = await _uploadFile([
                        front!,
                        back!,
                        left!,
                        right!,
                        other!,
                      ]);

                      if (downloadUrls.isNotEmpty) {
                        Car carObj = Car(
                          id: widget.id,
                          parkingLotId: car.parkingLotId,
                          carStatusId: car.carStatusId == 1
                              ? 2
                              : car.carStatusId, // từ 1 = đang thẩm định sang 2 = sẵn sàng cho thuê
                          carLicensePlates: car.carLicensePlates,
                          seatNumber: car.seatNumber,
                          modelYear: car.modelYear,
                          carMakeId: car.carMakeId,
                          carModelId: car.carModelId,
                          carGenerationId: car.carGenerationId,
                          carSeriesId: car.carSeriesId,
                          carTrimId: car.carTrimId,
                          carDescription: car.carDescription,
                          createdDate: car.createdDate,
                          isDeleted: car.isDeleted,
                          carColor: car.carColor,
                          carFuel: car.carFuel,
                          periodicMaintenanceLimit: car.periodicMaintenanceLimit,
                          priceForNormalDay: car.priceForNormalDay,
                          priceForWeekendDay: car.priceForWeekendDay,
                          priceForMonth: car.priceForMonth,
                          limitedKmForMonth: car.limitedKmForMonth,
                          overLimitedMileage: car.overLimitedMileage,
                          carStatusDescription: car.carStatusDescription,
                          currentEtcAmount: car.currentEtcAmount,
                          fuelPercent: car.fuelPercent,
                          speedometerNumber: car.speedometerNumber,
                          carOwnerName: car.carOwnerName,
                          rentalMethod: car.rentalMethod,
                          rentalDate: car.rentalDate,
                          speedometerNumberReceive: car.speedometerNumberReceive,
                          ownerSlitRatio: car.ownerSlitRatio,
                          priceForDayReceive: car.priceForDayReceive,
                          priceForMonthReceive: car.priceForMonthReceive,
                          insurance: car.insurance,
                          limitedKmForMonthReceive: car.limitedKmForMonthReceive,
                          overLimitedMileageReceive: car.overLimitedMileageReceive,
                          frontImg: downloadUrls[0],
                          backImg: downloadUrls[1],
                          leftImg: downloadUrls[2],
                          rightImg: downloadUrls[3],
                          ortherImg: downloadUrls[4],
                          carFileCreatedDate: car.carFileCreatedDate,
                          linkTracking: car.linkTracking,
                          trackingUsername: car.trackingUsername,
                          trackingPassword: car.trackingPassword,
                          etcusername: car.etcusername,
                          etcpassword: car.etcpassword,
                          tankCapacity: car.tankCapacity,
                        );
                        // await _updateCar(widget.id, carObj);
                        CarCubit cubit = context.read<CarCubit>();
                        await cubit.updateCarImage(widget.id, carObj);
                        if (cubit.state.status == CarStatus.succcess) {
                          _loadById(widget.id);
                        }
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

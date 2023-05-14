// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:booking_car/Screens/contractGroup/step_4_transfer_contract/components/list_tile.dart';
import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_expense/car_expense_cubit.dart';
import 'package:booking_car/blocs/cubit/car_schedule/car_schedule_cubit.dart';
import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/blocs/cubit/rent_contract/rent_contract_cubit.dart';
import 'package:booking_car/blocs/cubit/transfer_contract/transfer_contract_cubit.dart';
import 'package:booking_car/components/cicular_loading.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:booking_car/components/signature_pad.dart';
import 'package:booking_car/components/verify_phone_number.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/models/car_expense.dart';
import 'package:booking_car/models/car_expense_post.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/models/receive_post.dart';
import 'package:booking_car/models/receive_put.dart';
import 'package:booking_car/screens/contractGroup/components/custom_big_title.dart';
import 'package:booking_car/screens/contractGroup/components/pdf_read.dart';
import 'package:booking_car/screens/contractGroup/step5_receive_contract/components/return_deposit.dart';
import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/components/container_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../components/divider.dart';

File? frontImage;
File? backImage;
File? leftImage;
File? rightImage;
File? insideImage;
File? damageImage;
bool? isFrontImage;
bool? isLeftImage;
bool? isInsideImage;
int? speedometerNumber;
int? fuelPercent;
int? etcAmount;
String? staffSignature;
String? customerSignature;

class ReceiveContractScreen extends StatefulWidget {
  final int contractGroupId;
  final ContractGroup? contractGroup;
  final Function reloadStep;
  int? status;
  ReceiveContractScreen(
      {Key? key,
      required this.contractGroupId,
      this.contractGroup,
      this.status,
      required this.reloadStep})
      : super(key: key);

  @override
  State<ReceiveContractScreen> createState() => _ReceiveContractScreenState();
}

class _ReceiveContractScreenState extends State<ReceiveContractScreen> {
  late List<File> listImage = [];

  late File? staffSig;
  late File? customerSig;

  late String front;
  late String back;
  late String left;
  late String right;
  late String inside;
  late String damage;
  late String depositItemDescription;

  late int speedometerNumber;
  late int fuelPercent;
  late int etcAmount;
  late String carStatusDescription;
  late String receiveAddress;
  late String currentCarDescription;
  late String depositItemAssets;
  late int depositItemDownPayment;
  late int carInsuranceMoney;
  late String carDamageDescription;
  late String speedingViolationDescription;
  late String forbiddenRoadViolationDescription;
  late String trafficLightViolationDescription;
  late String ortherViolation;
  late int extraTime;
  late int unpaidTicketMoney;
  late int speedoBeforeTransfer;
  late int violationMoney;
  late bool? selected = true;
  late bool? detectedViolations = true;
  late double opacit = 0.0;
  late double opacitViolations = 0.0;
  late bool? isReturnDep;
  String deliveryAddress = '';

  // transfer contract field
  int speedoTransfer = 0;
  int fuelTransfer = 0;
  int etcTransfer = 0;
  int transferContractID = 0;

  int carID = 0;

  String depositItemAssetsDescription = '';
  bool isStaffSigned = false;
  bool verified = false;
  List<File> allPics = [];
  List<File> notReturnDeposit = [];
  List<Widget> rows = [];

  void _updateImageList(List<File> listImage) {
    setState(() {
      notReturnDeposit = listImage;
    });
  }

  void addToAllImages(List<File> listNotReturnDeposit) {
    for (var i = 0; i < listNotReturnDeposit.length; i++) {
      setState(() {
        allPics.add(listNotReturnDeposit[i]);
      });
    }
  }

  isVerified(bool isVerified) {
    setState(() {
      verified = isVerified;
    });
  }

  setStaffSig(File sig) {
    setState(() {
      isStaffSigned = true;
      staffSig = sig;
    });
  }

  setCustomerSig(File sig) {
    setState(() {
      customerSig = sig;
    });
  }

  void clearImageArray(
      List<String> listDownload, List<ReceiveContractFileCreateModels> transferModels) {
    setState(() {
      allPics.clear();
      listDownload.clear();
      transferModels.clear();
      frontImage = null;
      backImage = null;
      leftImage = null;
      rightImage = null;
      insideImage = null;
    });
  }

  late final GlobalKey<SfSignaturePadState> _signaturePadKey;

  final GlobalKey<_ReceiveContractScreenState> receiveKey =
      GlobalKey<_ReceiveContractScreenState>();

  void _setFrontImage(File frontImg) {
    setState(() {
      frontImage = frontImg;
    });
  }

  void _setBackImage(File backImg) {
    setState(() {
      backImage = backImg;
    });
  }

  void _setLeftImage(File leftImg) {
    setState(() {
      leftImage = leftImg;
    });
  }

  void _setRightImage(File rightImg) {
    setState(() {
      rightImage = rightImg;
    });
  }

  void _setInsideImage(File insideImg) {
    setState(() {
      insideImage = insideImg;
    });
  }

  // bool checkSpeedoInput(int speedoAfterReceive) {
  //   if (speedoAfterReceive < speedoBeforeTransfer) {
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> _loadContractDetail(int contractGroupId) async {
    context.read<CarCubit>().getDetailThenGetCar(contractGroupId);
    context.read<TransferContractCubit>().getTransferContract(contractGroupId);
  }

  Future<void> _loadReceiveContractDetail(int contractGroupId) async {
    context.read<ReceiveContractCubit>().getDetailThenReceiveContract(contractGroupId);
  }

  Future<void> _loadContractGroup(int contractGroupId) async {
    context.read<ContractGroupCubit>().getContractGroup(contractGroupId);
  }

  Future<void> _loadRentContract(int contractGroupId) async {
    context.read<RentContractCubit>().getRentContract(contractGroupId);
  }

  final Map<int, String> _firstFivePics = const {
    0: 'Ảnh xe mặt trước',
    1: 'Ảnh xe mặt sau',
    2: 'Ảnh xe mặt trái',
    3: 'Ảnh xe mặt phải',
    4: 'Ảnh nội thất xe',
  };

  Future<String> _uploadSingleFile(File uploadImage) async {
    String downloadURLs = "";
    try {
      final _storage = FirebaseStorage.instance.ref().child('mobile/${DateTime.now()}.png');

      final downloadURLs =
          _storage.putFile(uploadImage).then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());

      return downloadURLs;
    } on PlatformException catch (e) {
      print(e);
    }
    return downloadURLs;
  }

  Future<List<String>> _uploadFile(List<File> listImage) async {
    List<String> downloadURLs = [];
    try {
      final List<Future<String>> uploadTasks = [];
      for (final file in listImage) {
        final _storage = FirebaseStorage.instance.ref().child('mobile/${DateTime.now()}.png');

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

  Future<dynamic> _showSignatureDialog(BuildContext context) async {
    return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: SfSignaturePad(
                  backgroundColor: Colors.white,
                  key: _signaturePadKey,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final signatureData = await _signaturePadKey.currentState!.toImage();
                  final bytes = await signatureData.toByteData(format: ImageByteFormat.png);
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      '${directory.path}/signature_${DateTime.now().microsecondsSinceEpoch}.png';
                  final file = File(imagePath);
                  await file.writeAsBytes(bytes!.buffer.asUint8List());
                  Navigator.pop(context, file);
                },
                child: const Text('Lưu chữ kí'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _createReceiveRecord(ReceivePost receivePost) async {
  //   context.read<ReceiveContractCubit>().postReceiveContract(receivePost);
  //   context.read<ReceiveContractCubit>().stream.listen((event) {
  //     if (event.status == ReceiveContractStatus.success) {
  //       EasyLoading.showSuccess("Tạo biên bản thành công");
  //       EasyLoading.dismiss();
  //       widget.reloadStep(widget.contractGroupId);
  //       return;
  //     } else if (event.status == ReceiveContractStatus.failure) {
  //       EasyLoading.showError("Tạo biên bản thất bại");
  //       widget.reloadStep(widget.contractGroupId);
  //       EasyLoading.dismiss();
  //     }
  //   });
  //   context.read<ReceiveContractCubit>().getDetailThenReceiveContract(widget.contractGroupId);
  // }
  Future<void> _createReceiveRecord(ReceivePost receivePost) async {
    final receiveContractCubit = context.read<ReceiveContractCubit>();
    final contractGroupId = widget.contractGroupId;
    try {
      await receiveContractCubit.postReceiveContract(receivePost);
      EasyLoading.showSuccess("Tạo biên bản thành công");
      widget.reloadStep(contractGroupId);
    } catch (e) {
      EasyLoading.showError("Tạo biên bản thất bại");
      widget.reloadStep(contractGroupId);
    } finally {
      EasyLoading.dismiss();
    }
    receiveContractCubit.getDetailThenReceiveContract(contractGroupId);
  }

  Future<void> _updateReceiveRecord(ReceivePut receivePut, int receiveId) async {
    context.read<ReceiveContractCubit>().updateReceiveContract(receivePut, receiveId);
    context.read<ReceiveContractCubit>().stream.listen((event) {
      if (event.status == ReceiveContractStatus.success) {
        EasyLoading.showSuccess("Cập nhật biên bản thành công");
        EasyLoading.dismiss();
        widget.reloadStep(widget.contractGroupId);
        return;
      } else if (event.status == ReceiveContractStatus.failure) {
        EasyLoading.showError("Cập nhật biên bản thất bại");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      }
    });
    context.read<ReceiveContractCubit>().getDetailThenReceiveContract(widget.contractGroupId);

    // await context.read<ReceiveContractCubit>().getDetailThenReceiveContract(widget.contractGroupId);
    // await widget.reloadStep(widget.contractGroupId);
  }

  Future<void> _updateStatusContractGroup(int contractGroupId, ContractGroup cg) async {
    context.read<ContractGroupCubit>().updateStatus(contractGroupId, cg);
    context.read<ContractGroupCubit>().stream.listen((event) {
      if (event.status == ContractGroupStatus.succcess) {
        EasyLoading.showSuccess("Cập nhật trạng thái thành công");
        if (mounted) {
          Navigator.pop(context);
        }
        EasyLoading.dismiss();
      } else if (event.status == ContractGroupStatus.error) {
        EasyLoading.showError("Cập nhật trạng thái thất bại");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      }
    });
  }

  void fetchData() async {
    // setState(() {
    //   allPics.clear();
    //   notReturnDeposit.clear();
    // });
    // widget.reloadStep(1);
    _loadRentContract(widget.contractGroupId);
    _loadContractDetail(widget.contractGroupId);
    _loadReceiveContractDetail(widget.contractGroupId);
  }

  @override
  void initState() {
    print('contractGroupId: ${widget.contractGroupId}');
    print('status ne ${widget.status} ');
    _loadRentContract(widget.contractGroupId);
    _loadContractDetail(widget.contractGroupId);
    _loadReceiveContractDetail(widget.contractGroupId);
    _loadContractGroup(widget.contractGroupId);
    selected = true;
    receiveAddress = '';
    speedometerNumber = 0;
    fuelPercent = 0;
    etcAmount = 0;
    carStatusDescription = '';
    depositItemAssets = '';
    depositItemDownPayment = 0;
    carInsuranceMoney = 0;
    carDamageDescription = '';
    speedingViolationDescription = '';
    forbiddenRoadViolationDescription = '';
    trafficLightViolationDescription = '';
    currentCarDescription = '';
    ortherViolation = '';
    extraTime = 0;
    unpaidTicketMoney = 0;

    violationMoney = 0;
    front = '';
    back = '';
    left = '';
    right = '';
    inside = '';
    damage = '';
    speedoBeforeTransfer = 0;
    customerSig = null;
    staffSig = null;
    isReturnDep = true;

    staffSignature = "";
    customerSignature = "";
    _signaturePadKey = GlobalKey<SfSignaturePadState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String parkinglotAddress = "";
    String checkUrl(String url) {
      if (url.startsWith('http')) {
        return url;
      } else {
        return ERROR_PHOTO;
      }
    }

    return BlocBuilder<ContractGroupCubit, ContractGroupState>(
      builder: (context, state) {
        var f = NumberFormat('#,###', 'en_US');
        String parkingAddress;
        final phoneNumber = state.contractGroup?.phoneNumber;
        deliveryAddress =
            state.contractGroup?.deliveryAddress.toString() ?? 'Không có địa chỉ nhận';
        int statusContractGroup = state.contractGroup?.contractGroupStatusId ?? 0;
        widget.status = statusContractGroup;
        String customerIdentityCard = state.contractGroup?.customerFiles?[0].documentImg ?? "";
        String customerIdentityCardTitle =
            state.contractGroup?.customerFiles?[0].title ?? 'Ảnh CCCD/CMND';
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                ),
                child: Column(
                  children: [
                    //Thông tin xe
                    BlocBuilder<CarCubit, CarState>(
                      builder: (context, state) {
                        carID = state.car?.id ?? 0;
                        String licensePlate = state.car?.carLicensePlates ?? "";
                        speedoBeforeTransfer = state.car?.speedometerNumber ?? 0;
                        parkinglotAddress = state.car?.parkingLotName ?? "";
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomDescription(
                                title: 'Thông tin xe',
                                description: 'Xe khách hàng sử dụng trong thời gian hợp đồng'),
                            CustomTileContract(
                              listTitle: const [
                                'Tên xe',
                                'Hãng xe',
                                'Phiên bản',
                                'Phân khúc',
                                'Truyền động',
                                'Năm sản xuất',
                                'Màu xe',
                                'Số ghế',
                                'Biển số xe',
                                'Xe thuộc bãi'
                              ],
                              listContent: [
                                state.car?.modelName ?? '',
                                state.car?.makeName ?? '',
                                state.car?.generationName ?? '',
                                state.car?.seriesName ?? '',
                                state.car?.trimName ?? '',
                                state.car?.modelYear.toString() ?? '',
                                state.car?.carColor ?? '',
                                state.car?.seatNumber.toString() ?? '',
                                licensePlate,
                                parkinglotAddress,
                              ],
                              isEnable: false,
                            ),
                          ],
                        );
                      },
                    ),
                    CustomDivider(),
                    //  Thông tin thuê xe
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDescription(
                                title: 'Thông tin thuê xe',
                                description: 'Thông tin thuê xe của khách hàng ',
                              ),
                              CustomTileContract(
                                listTitle: const [
                                  'Ngày bắt đầu',
                                  'Ngày kết thúc',
                                ],
                                listContent: [
                                  state.contractGroup?.rentFrom.toString() ?? "",
                                  state.contractGroup?.rentTo.toString() ?? "",
                                ],
                                isEnable: false,
                              ),
                              CustomTileContract(
                                height: 50,
                                listTitle: const [
                                  'Địa chỉ giao xe',
                                ],
                                listContent: [
                                  state.contractGroup?.deliveryAddress.toString() ?? "",
                                ],
                                isEnable: false,
                              ),
                              BlocBuilder<RentContractCubit, RentContractState>(
                                  builder: (context, state) {
                                depositItemAssetsDescription =
                                    state.rentContract?.depositItemDownPayment.toString() ??
                                        dontHave;
                                deliveryAddress =
                                    state.rentContract?.deliveryAddress.toString() ?? "";
                                return CustomTileContract(
                                  listTitle: const [
                                    'Địa chỉ nhận xe',
                                    'Giá trị hợp đồng',
                                    'Tiền cọc',
                                  ],
                                  listContent: [
                                    parkinglotAddress.toString(),
                                    '${f.format(
                                      int.parse(
                                        state.rentContract?.paymentAmount.toString() ?? '0',
                                      ),
                                    )} VNĐ',
                                    '${f.format(
                                      int.parse(
                                        state.rentContract?.depositItemDownPayment.toString() ??
                                            '0',
                                      ),
                                    )} VNĐ',
                                  ],
                                  isEnable: false,
                                );
                              }),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20)),
                              SizedBox(
                                width: 200,
                                height: 150,
                                child: Image.network(
                                  checkUrl(customerIdentityCard),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                customerIdentityCardTitle,
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomDivider(),
                    //Hình ảnh xe đã nhận
                    widget.status != 11 || statusContractGroup != 11
                        ? Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                            ),
                            child: Column(
                              children: [
                                CustomDescription(
                                  title: 'Hiện trạng xe',
                                  description:
                                      'Tình trạng xe hiện tại khi nhận từ khách hàng sau khi thuê',
                                ),
                                BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                  builder: (context, state) {
                                    print('receiveContract: ${state.response.toString()}');
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white12,
                                      ),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomTileContract(
                                                listTitle: const [
                                                  'Số đồng hồ khi nhận',
                                                  'Mức nhiên liệu khi nhận',
                                                  'Tài khoản ETC khi nhận',
                                                  'Tiền xăng hiện tại',
                                                  'Mô tả xe'
                                                ],
                                                listContent: [
                                                  state.response?.currentCarStateSpeedometerNumber
                                                          .toString() ??
                                                      'Không xác định',
                                                  state.response?.currentCarStateFuelPercent
                                                          .toString() ??
                                                      'Không xác định',
                                                  f.format(
                                                    int.parse(
                                                      state.response?.currentFuelMoney.toString() ??
                                                          '0',
                                                    ),
                                                  ),
                                                  f.format(
                                                    int.parse(
                                                      state.response
                                                              ?.currentCarStateCurrentEtcAmount
                                                              .toString() ??
                                                          '0',
                                                    ),
                                                  ),
                                                  state.response
                                                          ?.currentCarStateCarStatusDescription
                                                          .toString() ??
                                                      'Không xác định',
                                                ],
                                                isEnable: false,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),

                    CustomDivider(),
                    Container(
                      child: Column(
                        children: [
                          CustomDescription(
                            title: 'Hình ảnh xe khi giao',
                            description:
                                'Tình trạng xe trước khi giao đến khách hàng (bằng hình ảnh)',
                          ),
                          BlocBuilder<TransferContractCubit, TransferContractState>(
                            builder: (context, state) {
                              final imageUrls =
                                  state.transferModel?.transferContractFileDataModels ?? [];
                              return Wrap(
                                spacing: 10,
                                alignment: WrapAlignment.spaceBetween,
                                children: imageUrls.map((image) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          (image.documentImg!.startsWith("http"))
                                              ? image.documentImg!
                                              : ERROR_PHOTO,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              ERROR_PHOTO,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Text(image.title ?? "Ảnh xe"),
                                        Padding(padding: EdgeInsets.only(bottom: 10)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(),
                    Container(
                      child: Column(
                        children: [
                          CustomDescription(
                            title: 'Hình ảnh xe khi nhận',
                            description:
                                'Tình trạng xe trước khi nhận từ khách hàng (bằng hình ảnh)',
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          widget.status == 11
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomCamera(
                                          onPictureTaken: _setFrontImage,
                                          onPictureDeleted: _setFrontImage,
                                          setFront: _setFrontImage,
                                          isTakenPicture: false,
                                          imgDescription: 'Ảnh phía trước',
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 40)),
                                        CustomCamera(
                                            onPictureTaken: _setBackImage,
                                            onPictureDeleted: _setBackImage,
                                            setBack: _setBackImage,
                                            isTakenPicture: false,
                                            imgDescription: 'Ảnh phía sau'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomCamera(
                                            onPictureTaken: _setLeftImage,
                                            onPictureDeleted: _setLeftImage,
                                            setLeft: _setLeftImage,
                                            isTakenPicture: false,
                                            imgDescription: 'Ảnh bên trái'),
                                        Padding(padding: EdgeInsets.only(left: 40)),
                                        CustomCamera(
                                            onPictureTaken: _setRightImage,
                                            onPictureDeleted: _setRightImage,
                                            setRight: _setRightImage,
                                            isTakenPicture: false,
                                            imgDescription: 'Ảnh bên phải'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomCamera(
                                            onPictureTaken: _setInsideImage,
                                            onPictureDeleted: _setInsideImage,
                                            setInside: _setInsideImage,
                                            isTakenPicture: false,
                                            imgDescription: 'Ảnh nội thất'),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                                    Text(
                                      'Nhấn để chụp lại ảnh, giữ để xóa *',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    BlocBuilder<TransferContractCubit, TransferContractState>(
                                      builder: (context, state) {
                                        transferContractID = state.transferModel?.id ?? 0;
                                        fuelPercent =
                                            state.transferModel?.currentCarStateFuelPercent ?? 0;
                                        etcAmount =
                                            state.transferModel?.currentCarStateCurrentEtcAmount ??
                                                0;
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CustomTextField(
                                              initialText: state
                                                  .transferModel?.currentCarStateSpeedometerNumber
                                                  .toString(),
                                              endIcon: Text(
                                                "km",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              title: 'Số đồng hồ hiện tại',
                                              keyboardType: TextInputType.number,
                                              onChangedString:
                                                  context.read<CarCubit>().onChangeSpeedoNumber,
                                              // errorText: (value) {
                                              //   final valueInt = int.parse(value ?? '0');
                                              //   final prevValue = state
                                              //       .transferModel?.currentCarStateSpeedometerNumber
                                              //       .toString();
                                              //   Validators().speedoValid(
                                              //     valueInt,
                                              //     int.parse(prevValue ?? '0'),
                                              //   );
                                              // },
                                            ),
                                            CustomTextField(
                                              initialText: state
                                                  .transferModel?.currentCarStateFuelPercent
                                                  .toString(),
                                              endIcon: Text(
                                                "%",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              title: 'Mức nhiên liệu còn lại',
                                              onChangedString:
                                                  context.read<CarCubit>().onChangeFuelPercentage,
                                              keyboardType: TextInputType.number,
                                            ),
                                            CustomTextField(
                                              initialText: state
                                                  .transferModel?.currentCarStateCurrentEtcAmount
                                                  .toString(),
                                              endIcon: Text(
                                                "đ",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              title: 'Tài khoản ETC hiện tại',
                                              onChangedString:
                                                  context.read<CarCubit>().onChangeETCAmount,
                                              keyboardType: TextInputType.number,
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
                                              title: 'Giá nhiên liệu hiện tại',
                                              onChangedString: context
                                                  .read<ReceiveContractCubit>()
                                                  .onChangeFuelMoneyCheck,
                                              keyboardType: TextInputType.number,
                                            ),
                                            CustomTextField(
                                              title: 'Mô tả tình trạng xe',
                                              onChangedString: context
                                                  .read<CarCubit>()
                                                  .onChangeCarStatusDescription,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    CustomTextField(
                                      endIcon: Text(
                                        "giờ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      title: 'Vượt thời gian',
                                      onChangedString: context
                                          .read<ReceiveContractCubit>()
                                          .onChangeOverHourCheck,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                )
                              : BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                  builder: (context, state) {
                                    final imageUrls =
                                        state.response?.receiveContractFileDataModels ?? [];
                                    return Wrap(
                                      spacing: 10,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: imageUrls.map((image) {
                                        return Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Column(
                                            children: [
                                              Image.network(
                                                (image.documentImg!.startsWith("http"))
                                                    ? image.documentImg!
                                                    : ERROR_PHOTO,
                                                height: 150,
                                                width: 150,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    ERROR_PHOTO,
                                                    height: 150,
                                                    width: 150,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 10)),
                                              Text(image.title ?? "Ảnh xe"),
                                              Padding(padding: EdgeInsets.only(bottom: 10)),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                    CustomDivider(),
                    //Thiệt hại
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDescription(
                          title: 'Hoàn cọc',
                          description: 'Có hoàn cọc hay không',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: widget.status == 11
                                  ? ReturnDepositCheck(
                                      onImageListUpdated: _updateImageList,
                                      isReturnDep: false,
                                      setEnabled: true,
                                      statusContract:
                                          state.contractGroup?.contractGroupStatusId ?? 11,
                                    )
                                  : widget.status == 12
                                      ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                          builder: (context, state) {
                                            isReturnDep =
                                                state.response?.returnDepostiItem ?? false;
                                            return ReturnDepositCheck(
                                              onImageListUpdated: _updateImageList,
                                              statusContract: widget.status!,
                                              isReturnDep: isReturnDep,
                                              setEnabled: false,
                                            );
                                          },
                                        )
                                      : widget.status == 16
                                          ? BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                              builder: (context, state) {
                                                isReturnDep =
                                                    state.response?.returnDepostiItem ?? false;
                                                return ReturnDepositCheck(
                                                  onImageListUpdated: _updateImageList,
                                                  statusContract: widget.status!,
                                                  isReturnDep: isReturnDep,
                                                  setEnabled: false,
                                                );
                                              },
                                            )
                                          : widget.status == 17
                                              ? BlocBuilder<ReceiveContractCubit,
                                                  ReceiveContractState>(
                                                  builder: (context, state) {
                                                    return CustomTextField(
                                                      initialText: state.response?.violationMoney
                                                              .toString() ??
                                                          '0',
                                                      endIcon: Text(
                                                        "đ",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      title: 'Tổng tiền vi phạm',
                                                      keyboardType: TextInputType.number,
                                                      onChangedString: (p0) {
                                                        if (p0 == null) {
                                                          context
                                                              .read<ReceiveContractCubit>()
                                                              .onChangeViolationMoneyCheck(state
                                                                  .response?.violationMoney
                                                                  .toString());
                                                        } else {
                                                          context
                                                              .read<ReceiveContractCubit>()
                                                              .onChangeViolationMoneyCheck(p0);
                                                        }
                                                      },
                                                    );
                                                  },
                                                )
                                              : Container(),
                            ),
                          ],
                        ),
                        /*
                      isReturnDep == false
                          ? Column(
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomDivider(),
                                        CustomDescription(
                                          title: 'Thiệt hại',
                                          description: 'Thiệt hại khi sử dụng xe',
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: widget.status == 11
                                                  ? DropdownButton<bool>(
                                                      isExpanded: true,
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: true,
                                                          child: Text('Ban đầu',
                                                              style: styleTextNormal),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: false,
                                                          child: Text('Thiệt hại',
                                                              style: styleTextNormal),
                                                        ),
                                                      ],
                                                      value: selected,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          selected = value;
                                                        });
                                                      },
                                                    )
                                                  : BlocBuilder<ReceiveContractCubit,
                                                      ReceiveContractState>(
                                                      builder: (context, state) {
                                                        selected = state.response
                                                                    ?.currentCarStateCarStatusDescription !=
                                                                null
                                                            ? false
                                                            : true;
                                                        return DropdownButton<bool>(
                                                          isExpanded: true,
                                                          items: const [
                                                            DropdownMenuItem(
                                                              value: true,
                                                              child: Text('Ban đầu',
                                                                  style: styleTextNormal),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: false,
                                                              child: Text('Thiệt hại',
                                                                  style: styleTextNormal),
                                                            ),
                                                          ],
                                                          value: selected,
                                                          onChanged: (bool? value) {
                                                            setState(() {
                                                              selected = value;
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ],
                                        ),
                                        selected == false
                                            ? Column(
                                                children: [
                                                  widget.status == 11
                                                      ? TakeMorePic(
                                                          description: 'hư hại',
                                                          onImageListUpdated: _updateImageList,
                                                          title: 'Thêm ảnh hư hại')
                                                      : Container(), // = 12 thì load ảnh hư hại
                                                  Container(
                                                    child: widget.status == 11
                                                        ? Column(
                                                            children: [
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Tiền bảo hiểm xe (ước tính)',
                                                              //     insuranceMoneyController,
                                                              //     TextInputType.number),
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     "Thông tin thiệt hại",
                                                              //     carDamageDescriptionController,
                                                              //     TextInputType.text),
                                                            ],
                                                          )
                                                        : BlocBuilder<ReceiveContractCubit,
                                                            ReceiveContractState>(
                                                            builder: (context, state) {
                                                              return Column(
                                                                children: [
                                                                  CustomTileContract(
                                                                    isEnable: false,
                                                                    listTitle: const [
                                                                      'Thông tin thiệt hại',
                                                                      'Tiền bảo hiểm ước tính'
                                                                    ],
                                                                    listContent: [
                                                                      state.response
                                                                              ?.currentCarStateCarDamageDescription ??
                                                                          'Không có',
                                                                      state.response?.insuranceMoney
                                                                              .toString() ??
                                                                          'Không có',
                                                                    ],
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                CustomDivider(),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomDescription(
                                        title: 'Xe gặp vi phạm',
                                        description: 'Xe bị vi phạm trong quá trình sử dụng',
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: DropdownButton<bool>(
                                              isExpanded: true,
                                              items: const [
                                                DropdownMenuItem(
                                                  value: true,
                                                  child: Text('Vi phạm', style: styleTextNormal),
                                                ),
                                                DropdownMenuItem(
                                                  value: false,
                                                  child:
                                                      Text('Không vi phạm', style: styleTextNormal),
                                                ),
                                              ],
                                              value: detectedViolations,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  detectedViolations = value;
                                                });
                                              },
                                            ),
                                          ),
                                          detectedViolations == true
                                              ? Container(
                                                  child: widget.status == 11
                                                      ? Container(
                                                          child: Column(
                                                            children: [
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Quá tốc độ (lần)',
                                                              //     speedingViolationDescriptionController,
                                                              //     TextInputType.number),
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Vào đường cấm (lần)',
                                                              //     forbiddenRoadViolationDescriptionController,
                                                              //     TextInputType.number),
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Vượt đèn đỏ (lần)',
                                                              //     trafficLightViolationDescriptionController,
                                                              //     TextInputType.number),
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Vi phạm khác (lần)',
                                                              //     ortherViolationController,
                                                              //     TextInputType.number),
                                                              // _customerText(
                                                              //     receiveKey,
                                                              //     context,
                                                              //     'Tiền phạt (ước tính)',
                                                              //     violationMoneyController,
                                                              //     TextInputType.number),
                                                            ],
                                                          ),
                                                        )
                                                      // khóa lại chỗ nhập vi phạm lúc sau
                                                      : BlocBuilder<ReceiveContractCubit,
                                                          ReceiveContractState>(
                                                          builder: ((context, state) {
                                                            return Column(
                                                              children: [
                                                                // _customerText(
                                                                //     receiveKey,
                                                                //     context,
                                                                //     'Quá tốc độ (lần)',
                                                                //     speedingViolationDescriptionController,
                                                                //     TextInputType.number),
                                                                // _customerText(
                                                                //     receiveKey,
                                                                //     context,
                                                                //     'Vào đường cấm (lần)',
                                                                //     forbiddenRoadViolationDescriptionController,
                                                                //     TextInputType.number),
                                                                // _customerText(
                                                                //     receiveKey,
                                                                //     context,
                                                                //     'Vượt đèn đỏ (lần)',
                                                                //     trafficLightViolationDescriptionController,
                                                                //     TextInputType.number),
                                                                // _customerText(
                                                                //     receiveKey,
                                                                //     context,
                                                                //     'Vi phạm khác (lần)',
                                                                //     ortherViolationController,
                                                                //     TextInputType.number),
                                                                // _customerText(
                                                                //     receiveKey,
                                                                //     context,
                                                                //     'Tiền phạt (ước tính)',
                                                                //     violationMoneyController,
                                                                //     TextInputType.number),
                                                              ],
                                                            );
                                                          }),
                                                        ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                           */
                      ],
                    ),

                    CustomDivider(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.status == 11
                              ? ElevatedButton(
                                  onPressed: (() async {
                                    EasyLoading.show(status: 'Đang tạo biên bản');
                                    if (frontImage == null ||
                                        backImage == null ||
                                        leftImage == null ||
                                        rightImage == null ||
                                        insideImage == null) {
                                      EasyLoading.showError('Vui lòng chụp ảnh xe',
                                          duration: Duration(seconds: 2));
                                      EasyLoading.dismiss();
                                      return;
                                    } else {
                                      allPics.add(frontImage!);
                                      allPics.add(backImage!);
                                      allPics.add(leftImage!);
                                      allPics.add(rightImage!);
                                      allPics.add(insideImage!);
                                    }
                                    addToAllImages(notReturnDeposit);
                                    debugPrint('notReturnDeposit: ${notReturnDeposit.length}');
                                    debugPrint('allPics: ${allPics.length}');
                                    if (allPics.isEmpty) {
                                      EasyLoading.showError('Vui lòng chụp ảnh còn thiếu');
                                      EasyLoading.dismiss();
                                      return;
                                    }
                                    CarCubit carCubit = context.read<CarCubit>();
                                    ReceiveContractCubit cubit =
                                        context.read<ReceiveContractCubit>();
                                    debugPrint(cubit.state.toString());
                                    debugPrint('speedo ${carCubit.state.speedoNumber}');

                                    final List<String> downloadUrls = await _uploadFile(allPics);
                                    print('downloadUrls: $downloadUrls');
                                    if (downloadUrls.isNotEmpty) {
                                      final receiveID =
                                          await FlutterSecureStorage().read(key: 'userID');
                                      String dateReceive = DateTime.now().toIso8601String();
                                      DateTime parseReceiveDate = DateTime.parse(dateReceive);
                                      String createDate = DateTime.now().toIso8601String();
                                      DateTime parseDate = DateTime.parse(createDate);

                                      List<ReceiveContractFileCreateModels> transferModels = [];
                                      for (int i = 0; i < downloadUrls.length; i++) {
                                        String title;
                                        if (i < 5 && _firstFivePics.containsKey(i)) {
                                          title = _firstFivePics[i]!;
                                          debugPrint('title: $title');
                                        } else {
                                          title = 'Ảnh xe hư hại thứ ${i - 4}';
                                        }
                                        transferModels.add(
                                          ReceiveContractFileCreateModels(
                                            title: title,
                                            documentImg: "${downloadUrls[i]}",
                                            documentDescription: 'Hình ảnh xe',
                                          ),
                                        );
                                      }
                                      bool original = false;
                                      bool detecViolation = cubit.state.isTrafficViolation!;
                                      bool returnDeposit = cubit.state.isReturnDeposit ?? false;
                                      int fuelPercentage = carCubit.state.fuelPercentage ?? 0;
                                      int etcAmount = carCubit.state.etcAmount ?? 0;
                                      int overHours = cubit.state.overHours ?? 0;
                                      int insuranceMoney = cubit.state.insurance ?? 0;
                                      int currentFuelMoney = cubit.state.currentFuelMoney ?? 0;
                                      String overSpeeds = cubit.state.overSpeeds.toString();
                                      String trafficViolation = cubit.state.roadViolates.toString();
                                      String passingRedLights =
                                          cubit.state.passingRedLights.toString();
                                      String anotherViolations =
                                          cubit.state.anotherViolations.toString();
                                      int violationMoney = cubit.state.violationMoney ?? 0;
                                      if (detecViolation == true) {
                                        returnDeposit = false;
                                        original = false;
                                      } else if (fuelPercentage < fuelTransfer ||
                                          etcAmount < etcTransfer ||
                                          overHours != 0) {
                                        original = true;
                                        returnDeposit = false;
                                      }
                                      depositItemAssetsDescription == dontHave
                                          ? 0
                                          : depositItemAssetsDescription;
                                      debugPrint('traffic violation $detecViolation');
                                      print('detectViolation $detectedViolations');
                                      print('returnDeposit $returnDeposit');
                                      print('original $original');
                                      ReceivePost receive = ReceivePost(
                                        receiverId: int.parse(receiveID!),
                                        contractGroupId: widget.contractGroupId,
                                        transferContractId: transferContractID,
                                        dateReceive: parseReceiveDate.toIso8601String(),
                                        receiveAddress: parkinglotAddress, // fix
                                        originalCondition: original,
                                        currentCarStateSpeedometerNumber:
                                            carCubit.state.speedoNumber,
                                        currentCarStateFuelPercent: fuelPercentage,
                                        currentCarStateCurrentEtcAmount: etcAmount,
                                        currentCarStateCarStatusDescription:
                                            carCubit.state.statusDescription,
                                        depositItemDownPayment:
                                            int.parse(depositItemAssetsDescription),
                                        returnDepostiItem: returnDeposit,
                                        createdDate: parseDate.toIso8601String(),
                                        currentCarStateCarDamageDescription:
                                            carCubit.state.statusDescription,
                                        insuranceMoney: 0,
                                        extraTime: overHours,
                                        currentFuelMoney: currentFuelMoney,
                                        detectedViolations: detecViolation,
                                        speedingViolationDescription: overSpeeds.toString(),
                                        forbiddenRoadViolationDescription:
                                            trafficViolation.toString(),
                                        trafficLightViolationDescription:
                                            passingRedLights.toString(),
                                        ortherViolation: anotherViolations.toString(),
                                        violationMoney: 0,
                                        receiveContractFileCreateModels: transferModels,
                                      );
                                      print(receive.toJson());
                                      await cubit.postReceiveContract(receive);

                                      widget.reloadStep(widget.contractGroupId);
                                      // _createReceiveRecord(receive);
                                      clearImageArray(downloadUrls, transferModels);
                                      EasyLoading.dismiss();
                                    }
                                  }),
                                  child: Text('Tạo biên bản'),
                                )
                              : BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            print('status xem hd = $statusContractGroup');
                                            debugPrint(' 123 ${state.response?.filePath}');
                                            debugPrint(
                                                ' 1233123123 ${state.response?.fileWithSignsPath}');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => (statusContractGroup == 12 ||
                                                        widget.status == 12 ||
                                                        widget.status == 16 ||
                                                        statusContractGroup == 16)
                                                    ? PdfReader(pdfUrl: state.response?.filePath)
                                                    : (widget.status == 13 ||
                                                            statusContractGroup == 13)
                                                        ? PdfReader(
                                                            pdfUrl:
                                                                state.response?.fileWithSignsPath)
                                                        : (widget.status == 17 ||
                                                                statusContractGroup == 17)
                                                            ? PdfReader(
                                                                pdfUrl: state
                                                                    .response?.fileWithSignsPath)
                                                            : PdfReader(
                                                                pdfUrl: state.response?.filePath),
                                              ),
                                            ); // 0902385340
                                          },
                                          child: Text('Xem biên bản'),
                                        ),
                                        Container(
                                          child: widget.status == 12 ||
                                                  statusContractGroup == 12 ||
                                                  widget.status == 16 ||
                                                  statusContractGroup == 16
                                              ? BlocBuilder<ReceiveContractCubit,
                                                  ReceiveContractState>(
                                                  builder: (context, state) {
                                                    isStaffSigned =
                                                        (state.response?.staffSignature) == null
                                                            ? false
                                                            : true;
                                                    return widget.status == 12 ||
                                                            statusContractGroup == 12
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              SignaturePad(
                                                                signatureFuction: setStaffSig,
                                                                signatureFile: staffSig,
                                                                title: 'Chữ kí nhân viên',
                                                              ),
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets.only(left: 50)),
                                                              SignaturePad(
                                                                signatureFuction: setCustomerSig,
                                                                signatureFile: customerSig,
                                                                title: 'Chữ kí khách hàng',
                                                              ), //
                                                            ],
                                                          )
                                                        : widget.status == 16 ||
                                                                statusContractGroup == 16
                                                            ? isStaffSigned == false
                                                                ? SignaturePad(
                                                                    signatureFuction: setStaffSig,
                                                                    signatureFile: staffSig,
                                                                    title: 'Chữ kí nhân viên',
                                                                  )
                                                                : verified == false
                                                                    ? SMSVerify(
                                                                        isVerified: isVerified,
                                                                        title: 'Xác nhận SĐT',
                                                                        phoneNum: phoneNumber!,
                                                                      )
                                                                    : SignaturePad(
                                                                        signatureFuction:
                                                                            setCustomerSig,
                                                                        signatureFile: customerSig,
                                                                        title: 'Chữ kí khách hàng',
                                                                      )
                                                            : Container();
                                                  },
                                                )
                                              : Container(
                                                  // child: Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.spaceEvenly,
                                                  //   children: [
                                                  //     Column(
                                                  //       children: [
                                                  //         Container(
                                                  //           height: 100,
                                                  //           width: 100,
                                                  //           child: Column(
                                                  //             children: [
                                                  //               Image.network(
                                                  //                 state.response
                                                  //                         ?.staffSignature! ??
                                                  //                     ERROR_PHOTO,
                                                  //                 fit: BoxFit.cover,
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //         Text('Chữ kí nhân viên')
                                                  //       ],
                                                  //     ),
                                                  //     Padding(padding: EdgeInsets.only(left: 50)),
                                                  //     Column(
                                                  //       children: [
                                                  //         Container(
                                                  //           height: 100,
                                                  //           width: 100,
                                                  //           child: Column(
                                                  //             children: [
                                                  //               Image.network(
                                                  //                 state.response
                                                  //                         ?.customerSignature! ??
                                                  //                     ERROR_PHOTO,
                                                  //                 fit: BoxFit.cover,
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //         Text('Chữ kí khách hàng')
                                                  //       ],
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  ),
                                        ),
                                        BlocBuilder<ReceiveContractCubit, ReceiveContractState>(
                                          builder: (context, state) {
                                            final checkStaffSig = state.response?.staffSignature;
                                            final uploadStaffSig;
                                            final uploadCustomerSig;
                                            if (state.status == TransferContractStatus.loading) {
                                              return CircularLoading();
                                            }
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                widget.status == 12 || statusContractGroup == 12
                                                    ? ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<Color>(
                                                                    Color.fromARGB(
                                                                        144, 48, 253, 55))),
                                                        onPressed: () async {
                                                          List<File> signatureList = [];
                                                          EasyLoading.show(
                                                              status: 'Đang cập nhật ...');
                                                          if (staffSig == null ||
                                                              customerSig == null) {
                                                            EasyLoading.dismiss();
                                                            EasyLoading.showError(
                                                                'Vui lòng kí tên');
                                                            EasyLoading.dismiss();
                                                          } else {
                                                            signatureList = [
                                                              staffSig!,
                                                              customerSig!
                                                            ];
                                                          }
                                                          final uploaded =
                                                              await _uploadFile(signatureList);

                                                          // print('speedo $speedoCar');
                                                          // if (speedoCar == "" ||
                                                          //     fuelCar == '' ||
                                                          //     etcAmount == "") return;
                                                          // if (staffSig != null) {
                                                          //   signatureList = [staffSig!];
                                                          // } else if (customerSig != null) {
                                                          //   // signatureList.insert(1, customerSig!);
                                                          //   signatureList = [customerSig!];
                                                          // } else {
                                                          //   signatureList = [staffSig!, customerSig!];
                                                          // }

                                                          // if (staffSig != null) {
                                                          //   staffSignature =
                                                          //       await _uploadSingleFile(staffSig!);
                                                          // } else if (customerSig != null) {
                                                          //   customerSignature =
                                                          //       await _uploadSingleFile(customerSig!);
                                                          // }
                                                          // print('customer $customerSignature');
                                                          int id = state.response?.id ?? 0;
                                                          // if staffsig != null || customersig != null -> tạo model post
                                                          if (staffSignature != "" ||
                                                              customerSignature != "") {
                                                            ReceivePut receivePut =
                                                                ReceivePut.fromReceiveModel(
                                                                    state.response!);
                                                            if (staffSignature != "") {
                                                              receivePut.staffSignature =
                                                                  staffSignature;
                                                            } else if (customerSignature != "") {
                                                              receivePut.customerSignature =
                                                                  customerSignature;
                                                            }
                                                            ReceiveContractCubit receiveCubit =
                                                                context
                                                                    .read<ReceiveContractCubit>();
                                                            receivePut.totalPayment = 0;
                                                            receivePut.insuranceMoney =
                                                                receiveCubit.state.insurance;
                                                            receivePut.violationMoney =
                                                                receiveCubit.state.violationMoney;
                                                            receivePut
                                                                    .trafficLightViolationDescription =
                                                                receiveCubit.state.passingRedLights;
                                                            receivePut.ortherViolation =
                                                                receiveCubit
                                                                    .state.anotherViolations;
                                                            receivePut.staffSignature = uploaded[0];
                                                            receivePut.customerSignature =
                                                                uploaded[1];
                                                            debugPrint(
                                                                'receivePut: ${receivePut.toJson()}');
                                                            // _updateReceiveRecord(receivePut, id);
                                                          } else {
                                                            EasyLoading.showError(
                                                                'Bạn cần phải kí tên trước');
                                                            EasyLoading.dismiss();
                                                          }
                                                        },
                                                        child: Text(
                                                          'Cập nhật',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.normal),
                                                        ),
                                                      )
                                                    : widget.status == 16 ||
                                                            statusContractGroup == 16
                                                        ? ElevatedButton(
                                                            onPressed: () async {
                                                              EasyLoading.show(
                                                                  status: 'Đang cập nhật');
                                                              int id = state.response?.id ?? 0;
                                                              print('staff sig $staffSig');
                                                              String uploadStaffSig = '';
                                                              if (staffSig != null) {
                                                                print(
                                                                    'staff sig != null $staffSig');
                                                                uploadStaffSig =
                                                                    await _uploadSingleFile(
                                                                        staffSig!);
                                                                print(
                                                                    'uploadStaffSig $uploadStaffSig');
                                                                CarCubit carCubit =
                                                                    context.read<CarCubit>();
                                                                Car carUpdate =
                                                                    Car(id: carID, carStatusId: 2);
                                                                ReceivePut receivePut =
                                                                    ReceivePut.fromReceiveModel(
                                                                        state.response!);
                                                                ReceiveContractCubit receiveCubit =
                                                                    context.read<
                                                                        ReceiveContractCubit>();
                                                                final insuranceMoney = receiveCubit
                                                                        .state.insurance ??
                                                                    state.response?.insuranceMoney;
                                                                final violationMoney = receiveCubit
                                                                        .state.violationMoney ??
                                                                    state.response?.violationMoney;
                                                                final trafficLight = receiveCubit
                                                                        .state.passingRedLights ??
                                                                    state.response
                                                                        ?.trafficLightViolationDescription;
                                                                final other = receiveCubit
                                                                        .state.anotherViolations ??
                                                                    state.response?.ortherViolation;
                                                                final speedViolate = receiveCubit
                                                                        .state.overSpeeds ??
                                                                    state.response
                                                                        ?.speedingViolationDescription;
                                                                receivePut.totalPayment = 0;
                                                                receivePut
                                                                        .speedingViolationDescription =
                                                                    speedViolate;
                                                                receivePut.insuranceMoney =
                                                                    insuranceMoney;
                                                                receivePut.violationMoney =
                                                                    violationMoney;
                                                                receivePut
                                                                        .trafficLightViolationDescription =
                                                                    trafficLight;
                                                                receivePut.ortherViolation = other;
                                                                receivePut.staffSignature =
                                                                    uploadStaffSig;
                                                                receivePut.customerSignature = null;
                                                                debugPrint(
                                                                    'receivePut: ${receivePut.toJson()}');
                                                                debugPrint(
                                                                    'receivePut: ${receiveCubit.state.toString()}');
                                                                // _updateReceiveRecord(
                                                                //     receivePut, id);
                                                                await receiveCubit
                                                                    .updateReceiveContract(
                                                                        receivePut, id);
                                                                await receiveCubit
                                                                    .getDetailThenReceiveContract(
                                                                        widget.contractGroupId);
                                                                await carCubit.updateCarStatus(
                                                                    carID, carUpdate);
                                                                widget.reloadStep(
                                                                    widget.contractGroupId);
                                                              } else if (checkStaffSig != null) {
                                                                String uploadCustomerSig = "";
                                                                if (customerSig != null) {
                                                                  // có chữ kí của khách
                                                                  uploadCustomerSig =
                                                                      await _uploadSingleFile(
                                                                          customerSig!);
                                                                  print(
                                                                      'uploadStaffSig $uploadCustomerSig');
                                                                  ReceivePut receivePut =
                                                                      ReceivePut.fromReceiveModel(
                                                                          state.response!);
                                                                  ReceiveContractCubit
                                                                      receiveCubit = context.read<
                                                                          ReceiveContractCubit>();
                                                                  final insuranceMoney =
                                                                      receiveCubit
                                                                              .state.insurance ??
                                                                          state.response
                                                                              ?.insuranceMoney;
                                                                  final violationMoney =
                                                                      receiveCubit.state
                                                                              .violationMoney ??
                                                                          state.response
                                                                              ?.violationMoney;
                                                                  final trafficLight = receiveCubit
                                                                          .state.passingRedLights ??
                                                                      state.response
                                                                          ?.trafficLightViolationDescription;
                                                                  final other = receiveCubit.state
                                                                          .anotherViolations ??
                                                                      state.response
                                                                          ?.ortherViolation;

                                                                  final speedViolate = receiveCubit
                                                                          .state.overSpeeds ??
                                                                      state.response
                                                                          ?.speedingViolationDescription;
                                                                  receivePut.totalPayment = 0;
                                                                  receivePut
                                                                          .speedingViolationDescription =
                                                                      speedViolate;
                                                                  receivePut.insuranceMoney =
                                                                      insuranceMoney;
                                                                  receivePut.violationMoney =
                                                                      violationMoney;
                                                                  receivePut
                                                                          .trafficLightViolationDescription =
                                                                      trafficLight;
                                                                  receivePut.ortherViolation =
                                                                      other;
                                                                  receivePut.staffSignature =
                                                                      checkStaffSig;
                                                                  receivePut.customerSignature =
                                                                      uploadCustomerSig;
                                                                  debugPrint(
                                                                      'receivePut: ${receivePut.toJson()}');
                                                                  debugPrint(
                                                                      'receivePut: ${receiveCubit.state.toString()}');
                                                                  // cập nhật chi phí
                                                                  final createDate = DateTime.now();
                                                                  // Car carUpdate = Car(
                                                                  //     id: carID, carStatusId: 2);
                                                                  // CarCubit carCubit =
                                                                  //     context.read<CarCubit>();
                                                                  CarExpenseCubit carExpenseCubit =
                                                                      context
                                                                          .read<CarExpenseCubit>();
                                                                  CarExpensePost carEx =
                                                                      CarExpensePost(
                                                                    carId: carID,
                                                                    title: 'Tiền bảo hiểm xe',
                                                                    amount: insuranceMoney ?? 0,
                                                                    day: createDate
                                                                        .toIso8601String(),
                                                                  );
                                                                  debugPrint(
                                                                      'carEx: ${carEx.toJson()}');
                                                                  await carExpenseCubit
                                                                      .postCarExpense(carEx);
                                                                  // cập nhật chữ kí
                                                                  await receiveCubit
                                                                      .updateReceiveContract(
                                                                          receivePut, id);
                                                                  // await carCubit.updateCarStatus(
                                                                  //     carID, carUpdate);
                                                                  await receiveCubit
                                                                      .getDetailThenReceiveContract(
                                                                          widget.contractGroupId);
                                                                  widget.reloadStep(
                                                                      widget.contractGroupId);
                                                                  // _updateReceiveRecord(
                                                                  //     receivePut, id);
                                                                  EasyLoading.dismiss();
                                                                } else {
                                                                  print(
                                                                      'uploadStaffSig $uploadCustomerSig');
                                                                  ReceivePut receivePut =
                                                                      ReceivePut.fromReceiveModel(
                                                                          state.response!);
                                                                  ReceiveContractCubit
                                                                      receiveCubit = context.read<
                                                                          ReceiveContractCubit>();
                                                                  final speedViolate = receiveCubit
                                                                          .state.overSpeeds ??
                                                                      state.response
                                                                          ?.speedingViolationDescription;
                                                                  final insuranceMoney =
                                                                      receiveCubit
                                                                              .state.insurance ??
                                                                          state.response
                                                                              ?.insuranceMoney;
                                                                  final violationMoney =
                                                                      receiveCubit.state
                                                                              .violationMoney ??
                                                                          state.response
                                                                              ?.violationMoney;
                                                                  final trafficLight = receiveCubit
                                                                          .state.passingRedLights ??
                                                                      state.response
                                                                          ?.trafficLightViolationDescription;
                                                                  final other = receiveCubit.state
                                                                          .anotherViolations ??
                                                                      state.response
                                                                          ?.ortherViolation;
                                                                  receivePut.totalPayment = 1;
                                                                  receivePut
                                                                          .speedingViolationDescription =
                                                                      speedViolate;
                                                                  receivePut.insuranceMoney =
                                                                      insuranceMoney;
                                                                  receivePut.violationMoney =
                                                                      violationMoney;
                                                                  receivePut
                                                                          .trafficLightViolationDescription =
                                                                      trafficLight;
                                                                  receivePut.ortherViolation =
                                                                      other;
                                                                  receivePut.staffSignature =
                                                                      checkStaffSig;
                                                                  debugPrint(
                                                                      'receivePut: ${receivePut.toJson()}');
                                                                  debugPrint(
                                                                      'receivePut: ${receiveCubit.state.toString()}');
                                                                  await receiveCubit
                                                                      .updateReceiveContract(
                                                                          receivePut, id);
                                                                  widget.reloadStep(
                                                                      widget.contractGroupId);
                                                                  // _updateReceiveRecord(
                                                                  //     receivePut, id);
                                                                }
                                                              } else if (staffSig == null ||
                                                                  checkStaffSig == null) {
                                                                EasyLoading.showError(
                                                                    'Chữ kí nhân viên không được để trống');
                                                                EasyLoading.dismiss();
                                                                return;
                                                              }
                                                              EasyLoading.dismiss();
                                                            },
                                                            child: Text(
                                                              'Cập nhật',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.normal),
                                                            ),
                                                          )
                                                        : Container(),
                                                Padding(padding: EdgeInsets.only(left: 10)),
                                                widget.status == 13 || statusContractGroup == 13
                                                    ? BlocBuilder<ReceiveContractCubit,
                                                        ReceiveContractState>(
                                                        builder: (context, state) {
                                                          int id = state.response?.id ?? 0;
                                                          return ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(Colors.lightBlue)),
                                                            onPressed: () async {
                                                              ReceiveContractCubit receiveCubit =
                                                                  context
                                                                      .read<ReceiveContractCubit>();
                                                              ContractGroupCubit
                                                                  contractGroupCubit = context
                                                                      .read<ContractGroupCubit>();
                                                              ReceivePut receivePut =
                                                                  ReceivePut.fromReceiveModel(
                                                                      state.response!);
                                                              receivePut.totalPayment = 0;
                                                              debugPrint(
                                                                  'receivePut: ${receivePut.totalPayment}');

                                                              await receiveCubit
                                                                  .updateReceiveContract(
                                                                      receivePut, id);
                                                              await contractGroupCubit.updateStatus(
                                                                  widget.contractGroupId,
                                                                  ContractGroup(
                                                                    id: widget.contractGroupId,
                                                                    contractGroupStatusId: 17,
                                                                  ));

                                                              widget.reloadStep(
                                                                  widget.contractGroupId);
                                                              // _updateStatusContractGroup(
                                                              //     widget.contractGroupId,
                                                              //     ContractGroup(
                                                              //       id: widget.contractGroupId,
                                                              //       contractGroupStatusId: 17,
                                                              //     ));

                                                              // allPics.clear();
                                                            },
                                                            child: Text('Hoàn thành'),
                                                          );
                                                        },
                                                      )
                                                    : widget.status == 17
                                                        ? BlocBuilder<ReceiveContractCubit,
                                                            ReceiveContractState>(
                                                            builder: (context, state) {
                                                              int id = state.response?.id ?? 0;
                                                              return ElevatedButton(
                                                                  onPressed: () async {
                                                                    ReceiveContractCubit
                                                                        receiveCubit = context.read<
                                                                            ReceiveContractCubit>();
                                                                    final moneyViolate =
                                                                        receiveCubit
                                                                            .state.violationMoney;
                                                                    ReceivePut receivePut =
                                                                        ReceivePut.fromReceiveModel(
                                                                            state.response!);
                                                                    receivePut.violationMoney =
                                                                        moneyViolate;
                                                                    receivePut.totalPayment = 0;
                                                                    await receiveCubit
                                                                        .updateReceiveContract(
                                                                            receivePut, id);
                                                                    widget.reloadStep(
                                                                        widget.contractGroupId);
                                                                    print(
                                                                        'moneyViolate: $moneyViolate');
                                                                  },
                                                                  child: Text(
                                                                      'Cập nhật tiền vi phạm'));
                                                            },
                                                          )
                                                        : Container(),
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

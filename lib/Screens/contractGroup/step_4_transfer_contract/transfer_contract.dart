import 'dart:io';

import 'package:booking_car/blocs/bloc/validators.dart';
import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/blocs/cubit/rent_contract/rent_contract_cubit.dart';
import 'package:booking_car/blocs/cubit/transfer_contract/transfer_contract_cubit.dart';
import 'package:booking_car/components/input_text_field.dart';
import 'package:booking_car/components/signature_pad.dart';
import 'package:booking_car/components/verify_phone_number.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/models/transfer_contract_files_create_model.dart';
import 'package:booking_car/models/transfer_post.dart';
import 'package:booking_car/models/transfer_put.dart';
import 'package:booking_car/screens/contractGroup/components/custom_big_title.dart';
import 'package:booking_car/screens/contractGroup/components/divider.dart';
import 'package:booking_car/screens/contractGroup/components/pdf_read.dart';
import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/components/container_camera.dart';
import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/components/list_tile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

bool? isFrontImage;
bool? isLeftImage;
bool? isInsideImage;
String? rentFrom;
String? rentTo;
String? staffSignature;
String? customerSignature;

class TransferContract extends StatefulWidget {
  final int contractGroupId;
  final ContractGroup? contractGroup;
  int? status;
  final Function nextStep;
  final Function reloadStep;
  final CarState carState;
  TransferContract({
    super.key,
    required this.carState,
    required this.reloadStep,
    required this.contractGroupId,
    required this.nextStep,
    this.status,
    required this.contractGroup,
  });

  @override
  State<TransferContract> createState() => _TransferContractState();
}

class _TransferContractState extends State<TransferContract> {
  late List<File> listImage = [];
  late String itemDown;
  late String depositDescription;
  late String assetDescription;
  late String currentCarDescription;
  late String front;
  late String back;
  late String left;
  late String right;
  late String dashboard;
  late String inside;
  late String? speedoCar;
  late String? fuelCar;
  late String? etcAmount;
  late File? staffSig;
  late File? customerSig;
  late String? license;
  late String? representativeId;
  late File? frontImage;
  late File? backImage;
  late File? leftImage;
  late File? rightImage;
  late File? dashboardImage; // bảng đồng hồ
  late File? insideImage;
  File? takenImage;
  String imageName = "Chưa có ảnh";

  String currSpeedo = "";
  String currFuel = "";
  String currEtcAmount = "";
  String deliveryFee = "";

  //phone
  bool verified = false;

  List<Widget> _rows = [];
  List<File> _imageFiles = [];

  final TextEditingController itemDownController = TextEditingController();
  final TextEditingController assetsController = TextEditingController();
  final TextEditingController descriptionContronller = TextEditingController();
  final TextEditingController currentCarController = TextEditingController();
  final TextEditingController speedoCarController = TextEditingController();
  final TextEditingController fuelCarController = TextEditingController();
  final TextEditingController etcAmountCarController = TextEditingController();

  final Map<int, String> _firstFivePics = const {
    0: 'Ảnh xe mặt trước',
    1: 'Ảnh xe mặt sau',
    2: 'Ảnh xe mặt trái',
    3: 'Ảnh xe mặt phải',
    4: 'Ảnh nội thất xe',
  };
  final Map<int, String> _threeDamagePics = const {
    0: 'Ảnh xe hư hại thứ 1',
    1: 'Ảnh xe hư hại thứ 2',
    2: 'Ảnh xe hư hại thứ 3',
  };

  Future<void> _createTransferContract(TransferPost transferPost) async {
    context.read<TransferContractCubit>().createTransferContract(transferPost);
    context.read<TransferContractCubit>().stream.listen((event) {
      if (event.status == TransferContractStatus.succcess) {
        EasyLoading.showSuccess("Tạo biên bản thành công");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      } else if (event.status == TransferContractStatus.error) {
        EasyLoading.showError("Tạo biên bản thất bại");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> _updateTransferContract(TransferPut transferPut, int transferId) async {
    context.read<TransferContractCubit>().updateTransferContract(transferPut, transferId);
    context.read<TransferContractCubit>().stream.listen((event) {
      if (event.status == TransferContractStatus.succcess) {
        EasyLoading.showSuccess("Cập nhật hợp đồng thành công");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      } else if (event.status == TransferContractStatus.error) {
        EasyLoading.showError("Cập nhật hợp đồng thất bại");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      }
    });
  }

  void _addRow() {
    print(_imageFiles.length);
    if (_imageFiles.length < 5) {
      _firstFivePics.forEach((key, value) {
        setState(() {
          _rows.add(CustomCamera(
            imgDescription: value,
            onPictureTaken: (File imageFile) {
              _imageFiles.add(imageFile);
            },
            onPictureDeleted: (File imageFile) {
              _imageFiles.remove(imageFile);
            },
          ));
        });
      });
    } else if ((_imageFiles.length < 8)) {
      _threeDamagePics.forEach((key, value) {
        setState(() {
          _rows.add(CustomCamera(
            imgDescription: value,
            onPictureTaken: (File imageFile) {
              _imageFiles.add(imageFile);
            },
            onPictureDeleted: (File imageFile) {
              _imageFiles.remove(imageFile);
            },
          ));
        });
      });
    } else {
      return;
    }
  }

  isVerified(bool isVerified) {
    setState(() {
      verified = isVerified;
    });
  }

  setStaffSig(File sig) {
    setState(() {
      staffSig = sig;
    });
  }

  setCustomerSig(File sig) {
    setState(() {
      customerSig = sig;
    });
  }

  void onSubmit() {
    setState(() {
      itemDown = itemDownController.text;
      assetDescription = assetsController.text;
      depositDescription = descriptionContronller.text;
      currentCarDescription = currentCarController.text;
      speedoCar = speedoCarController.text;
      fuelCar = fuelCarController.text;
      etcAmount = etcAmountCarController.text;
    });
  }

  Future<void> _cancelTransferRecord(int contractGroupID, int contractGroupStatusID) async {
    context.read<ContractGroupCubit>().updateStatus(contractGroupID,
        ContractGroup(id: contractGroupID, contractGroupStatusId: contractGroupStatusID));
    context.read<TransferContractCubit>().stream.listen((event) {
      if (event.status == ContractGroupStatus.succcess) {
        EasyLoading.showSuccess("Hủy biên bản thành công");
        Navigator.pop(context);
        EasyLoading.dismiss();
      } else if (event.status == ContractGroupStatus.error) {
        EasyLoading.showError("Hủy biên bản thất bại");
        widget.reloadStep(widget.contractGroupId);
        EasyLoading.dismiss();
      }
    });
  }

  Future _loadContractDetail(int contractGroupId) async {
    context.read<CarCubit>().getDetailThenGetCar(contractGroupId);
  }

  Future _loadTransferContract(int contractGroupId) async {
    context.read<TransferContractCubit>().getTransferContract(contractGroupId);
  }

  Future _loadRentContract(int contractGroupId) async {
    context.read<RentContractCubit>().getRentContract(contractGroupId);
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

  Future<void> fetchData() async {
    setState(() {
      _loadRentContract(widget.contractGroupId);
      _loadContractDetail(widget.contractGroupId);
      _loadTransferContract(widget.contractGroupId);
    });
  }

  @override
  void initState() {
    print('status ${widget.status}');
    _loadRentContract(widget.contractGroupId);
    _loadContractDetail(widget.contractGroupId);
    widget.status != 8
        ? _loadTransferContract(widget.contractGroupId)
        : _loadRentContract(widget.contractGroupId);
    _loadContractDetail(widget.contractGroupId);
    itemDown = '';
    depositDescription = '';
    assetDescription = '';
    currentCarDescription = '';
    speedoCar = "";
    fuelCar = "";
    etcAmount = "";
    front = '';
    representativeId = "";
    back = '';
    left = '';
    right = '';
    dashboard = '';
    inside = '';
    staffSig = null;
    customerSig = null;
    license = "";
    staffSignature = "";
    customerSignature = "";
    frontImage = null;
    backImage = null;
    leftImage = null;
    rightImage = null;
    dashboardImage = null;
    insideImage = null;

    currSpeedo = "";
    currFuel = "";
    currEtcAmount = "";
    deliveryFee = "";
    _imageFiles = [];

    super.initState();
  }

  String _parseDate(String date) {
    var dateParse = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    return dateParse.toString();
  }

  FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractGroupCubit, ContractGroupState>(
      builder: (context, state) {
        final phoneNumber = state.contractGroup?.phoneNumber;
        int statusContractGroup = state.contractGroup?.contractGroupStatusId ?? 0;
        String transferDateParsed =
            _parseDate(state.contractGroup?.rentFrom.toString() ?? DateTime.now().toString());
        return SingleChildScrollView(
          // height: MediaQuery.of(context).size.height - 200,
          child: Column(
            children: [
              BlocBuilder<CarCubit, CarState>(builder: (context, state) {
                currSpeedo = state.car?.speedometerNumber.toString() ?? "0";
                currFuel = state.car?.fuelPercent.toString() ?? "0";
                currEtcAmount = state.car?.currentEtcAmount.toString() ?? "0";
                print('currSpeedo $currSpeedo currFuel $currFuel currEtcAmount $currEtcAmount');
                license = state.car?.carLicensePlates;
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDescription(
                          title: 'Thông tin xe',
                          description: 'Xe khách hàng sử dụng trong thời gian hợp đồng',
                        ),
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
                            state.car?.carLicensePlates ?? '',
                            state.car?.parkingLotName ?? '',
                          ],
                          isEnable: false,
                        ),
                      ],
                    ),
                    CustomDivider(),
                    Column(
                      children: [
                        CustomDescription(
                          title: 'Hiện trạng xe',
                          description: 'Tình trạng xe hiện tại trước khi giao cho khách hàng',
                        ),
                        widget.status == 8 || statusContractGroup == 8
                            ? BlocBuilder<CarCubit, CarState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      CustomTextField(
                                        // validString: Validators().speedoValid(
                                        //     state.car?.speedometerNumber ?? 0,
                                        //     state.car?.speedometerNumber ?? 0),
                                        initialText: currSpeedo,
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
                                      ),
                                      CustomTextField(
                                        initialText: state.car?.fuelPercent.toString(),
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
                                        initialText: state.car?.currentEtcAmount.toString(),
                                        endIcon: Text(
                                          "đ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        title: 'Tài khoản ETC hiện tại',
                                        onChangedString: context.read<CarCubit>().onChangeETCAmount,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  );
                                  /*CustomTileContract(
                                    isEnable: true,
                                    listTitle: const [
                                      'Số đồng hồ hiện tại',
                                      'Mức nhiên liệu hiện tại',
                                      'Tài khoản ETC hiện tại'
                                    ],
                                    listContent: [
                                      state.car?.speedometerNumber.toString() ?? "",
                                      state.car?.fuelPercent.toString() ?? "",
                                      state.car?.currentEtcAmount.toString() ?? "",
                                    ],
                                  ) */
                                  // return Column(
                                  //   children: [
                                  //     CustomListTitle(
                                  //       errText: '123',
                                  //       backgroundColor: Colors.white,
                                  //       title: 'Số đồng hồ hiện tại',
                                  //       content: state.car?.speedometerNumber.toString() ?? 'Không',
                                  //     )
                                  //   ],
                                  // );
                                },
                              )
                            // : Container(),
                            : BlocBuilder<TransferContractCubit, TransferContractState>(
                                builder: (context, state) {
                                  return CustomTileContract(
                                    isEnable: false,
                                    listTitle: const [
                                      'Số đồng hồ hiện tại',
                                      'Mức nhiên liệu hiện tại',
                                      'Tài khoản ETC hiện tại'
                                    ],
                                    listContent: [
                                      state.transferModel?.currentCarStateSpeedometerNumber
                                              .toString() ??
                                          "",
                                      state.transferModel?.currentCarStateFuelPercent.toString() ??
                                          "",
                                      state.transferModel?.currentCarStateCurrentEtcAmount
                                              .toString() ??
                                          "",
                                    ],
                                  );
                                },
                              )
                      ],
                    ),
                  ],
                );
              }),
              CustomDivider(),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomDescription(
                      title: 'Thông tin thuê xe',
                      description: 'Khách hàng trả tiền cọc trước khi giao xe và ghi nhận lại',
                    ),
                    CustomTileContract(
                      isEnable: false,
                      listTitle: const [
                        'Khách hàng thuê từ',
                      ],
                      listContent: [
                        transferDateParsed,
                      ],
                    ),
                    CustomTileContract(
                      isEnable: false,
                      height: 50,
                      listTitle: const [
                        'Địa chỉ giao xe',
                      ],
                      listContent: [
                        state.contractGroup?.deliveryAddress.toString() ?? "",
                      ],
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Column(
                children: [
                  // widget.status == 8
                  statusContractGroup == 8 || widget.status == 8
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomDescription(
                                title: 'Hình ảnh xe',
                                description: 'Hiện trạng xe trước khi giao đến khách hàng',
                              ),
                              CustomTextField(
                                title: 'Tình trạng xe hiện tại',
                                onChangedString:
                                    context.read<CarCubit>().onChangeCarStatusDescription,
                              ),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  ..._rows,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _addRow();
                                        },
                                        child: Text('Thêm ảnh'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : BlocBuilder<TransferContractCubit, TransferContractState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                CustomTileContract(
                                  isEnable: false,
                                  listTitle: const [
                                    'Tình trạng xe hiện tại',
                                  ],
                                  listContent: [
                                    state.transferModel?.currentCarStateCarStatusDescription ??
                                        'Không có',
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                ],
              ),
              CustomDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // widget.status == 8
                  statusContractGroup == 8 || widget.status == 8
                      ? BlocBuilder<RentContractCubit, RentContractState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: (() async {
                                EasyLoading.show(status: 'Đang tạo biên bản ...');
                                if (_imageFiles.isEmpty) {
                                  EasyLoading.showError('Vui lòng chụp ảnh xe');
                                  EasyLoading.dismiss();
                                  return;
                                }
                                final List<String> downloadURLs = await _uploadFile(_imageFiles);
                                if (downloadURLs.isNotEmpty) {
                                  final transfererId =
                                      await FlutterSecureStorage().read(key: 'userID');
                                  String delivery = widget.contractGroup?.deliveryAddress ?? "";
                                  String createdDate = DateTime.now().toIso8601String();
                                  DateTime parsedDate = DateTime.parse(createdDate);

                                  String rentFrom = (widget.contractGroup?.rentFrom!).toString();
                                  DateTime rentFromDateTime = DateTime.parse(rentFrom);

                                  List<TransferContractFileCreateModels> transferModels = [];
                                  for (int i = 0; i < downloadURLs.length; i++) {
                                    String title;
                                    if (i < 6 && _firstFivePics.containsKey(i)) {
                                      title = _firstFivePics[i]!;
                                    } else {
                                      title = 'Ảnh ${i + 1}';
                                    }
                                    transferModels.add(
                                      TransferContractFileCreateModels(
                                        title: title,
                                        documentImg: downloadURLs[i],
                                        documentDescription: 'Hình ảnh xe',
                                      ),
                                    );
                                  }
                                  print(
                                      'deposit item down payment: ${state.rentContract?.depositItemDownPayment}');
                                  // ignore: use_build_context_synchronously
                                  CarCubit cubit = context.read<CarCubit>();
                                  print(
                                      'speedoNumber: ${cubit.state.speedoNumber}, fuelPercentage: ${cubit.state.fuelPercentage}, etcAmount: ${cubit.state.etcAmount}, statusDescription: ${cubit.state.statusDescription}');
                                  RentContractState rentContractState = RentContractState();
                                  // int itemDown =
                                  //     rentContractState.rentContract?.depositItemDownPayment ?? 0;
                                  final speedNum =
                                      cubit.state.speedoNumber ?? int.parse(currSpeedo);
                                  final fuelPer = cubit.state.fuelPercentage ?? int.parse(currFuel);
                                  final etcCurr = cubit.state.etcAmount ?? int.parse(currEtcAmount);
                                  final carStatusDescription = cubit.state.statusDescription;
                                  TransferPost model = TransferPost(
                                    transfererId: int.parse(transfererId!),
                                    contractGroupId: widget.contractGroup?.id,
                                    dateTransfer: rentFromDateTime.toIso8601String(),
                                    deliveryAddress: delivery,
                                    currentCarStateSpeedometerNumber: speedNum,
                                    currentCarStateFuelPercent: fuelPer,
                                    currentCarStateCurrentEtcAmount: etcCurr,
                                    currentCarStateCarStatusDescription: carStatusDescription,
                                    // depositItemDownPayment: rentContractState
                                    //     .rentContract?.depositItemDownPayment, // tiền cọc hđ
                                    depositItemDownPayment:
                                        state.rentContract?.depositItemDownPayment, // tiền cọc hđ
                                    createdDate: createdDate,
                                    transferContractFileCreateModels: transferModels,
                                  );
                                  debugPrint('model = ${model.toJson()}');
                                  TransferContractCubit transferContractCubit =
                                      context.read<TransferContractCubit>();
                                  await transferContractCubit.createTransferContract(model);
                                  widget.reloadStep(widget.contractGroupId);
                                  EasyLoading.dismiss();
                                  // _createTransferContract(model);
                                } else {
                                  EasyLoading.showError('Có lỗi xảy ra');
                                  EasyLoading.dismiss();
                                }
                              }),
                              child: Text('Tạo biên bản'),
                            );
                          },
                        )
                      : BlocBuilder<TransferContractCubit, TransferContractState>(
                          builder: (context, state) {
                            print(state.transferModel?.filePath);
                            print(state.transferModel?.fileWithSignsPath);
                            final customerSignature = state.transferModel?.customerSignature;
                            final staffSignature = state.transferModel?.staffSignature;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      // MaterialPageRoute(
                                      //   builder: (context) => (statusContractGroup == 9 ||
                                      //           widget.status == 9)
                                      //       ? PdfReader(
                                      //           pdfUrl: state.transferModel?.filePath,
                                      //         )
                                      //       : (statusContractGroup == 10 || widget.status == 10)
                                      //           ? PdfReader(
                                      //               pdfUrl: state.transferModel?.fileWithSignsPath,
                                      //             )
                                      //           : PdfReader(
                                      //               pdfUrl: state.transferModel?.filePath,
                                      //             ),
                                      // ),
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            (customerSignature != null && staffSignature != null)
                                                ? PdfReader(
                                                    pdfUrl: state.transferModel?.fileWithSignsPath,
                                                  )
                                                : PdfReader(
                                                    pdfUrl: state.transferModel?.filePath,
                                                  ),
                                      ),
                                    );
                                  },
                                  child: Text('Xem biên bản'),
                                ),
                                Container(
                                  // status = 10 = "Đã kí HĐ giao" -> không nhảy ra ô kí tên
                                  // child: widget.status == 9
                                  child: statusContractGroup == 9 || widget.status == 9
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SignaturePad(
                                              signatureFile: staffSig,
                                              title: 'Chữ kí nhân viên',
                                              signatureFuction: setStaffSig,
                                            ),
                                            Padding(padding: EdgeInsets.only(left: 50)),
                                            verified == false
                                                ? SMSVerify(
                                                    isVerified: isVerified,
                                                    title: 'Xác nhận SĐT',
                                                    phoneNum: phoneNumber!,
                                                  )
                                                : SignaturePad(
                                                    signatureFile: customerSig,
                                                    title: 'Chữ kí khách hàng',
                                                    signatureFuction: setCustomerSig,
                                                  ),
                                            // otp
                                          ],
                                        )
                                      : null,
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                BlocBuilder<TransferContractCubit, TransferContractState>(
                                  builder: (context, state) {
                                    if (state.status == TransferContractStatus.loading) {
                                      return CircularProgressIndicator();
                                    }
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        statusContractGroup == 9 || widget.status == 9
                                            ? Row(
                                                children: [
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty.all<Color>(
                                                                Color.fromARGB(144, 48, 253, 55))),
                                                    onPressed: () async {
                                                      EasyLoading.show(status: 'Đang cập nhật ...');
                                                      final modelTrans = state.transferModel;
                                                      List<File> signatureList = [
                                                        staffSig!,
                                                        customerSig!
                                                      ];
                                                      List<String> signatureUploaded =
                                                          await _uploadFile(signatureList);
                                                      int? id = modelTrans?.id;

                                                      TransferPut transferPut =
                                                          TransferPut.fromTransferModel(
                                                              state.transferModel!);
                                                      if (signatureUploaded.isNotEmpty) {
                                                        transferPut = transferPut.copyWith(
                                                            staffSignature: signatureUploaded[0],
                                                            customerSignature:
                                                                signatureUploaded[1]);
                                                        print(
                                                            'update model ${transferPut.toJson()}');
                                                        TransferContractCubit
                                                            transferContractCubit =
                                                            context.read<TransferContractCubit>();
                                                        await transferContractCubit
                                                            .updateTransferContract(
                                                                transferPut, id!);
                                                        await transferContractCubit
                                                            .getTransferContract(
                                                                widget.contractGroupId);
                                                        widget.reloadStep(widget.contractGroupId);

                                                        EasyLoading.dismiss();
                                                        // _updateTransferContract(transferPut, id!);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Cập nhật',
                                                      style:
                                                          TextStyle(fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text('Xác nhận'),
                                                            content: Text(
                                                                'Bạn có muốn hủy biên bản giao xe?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text('Không'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  ContractGroup cg = ContractGroup(
                                                                      id: widget.contractGroupId,
                                                                      contractGroupStatusId: 15);
                                                                  ContractGroupCubit
                                                                      contractGroupCubit =
                                                                      context.read<
                                                                          ContractGroupCubit>();
                                                                  await contractGroupCubit
                                                                      .updateStatus(
                                                                          widget.contractGroupId,
                                                                          cg);
                                                                  // ._cancelTransferRecord(
                                                                  //     widget.contractGroupId,
                                                                  //     15);
                                                                },
                                                                child: Text('Có'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text('Hủy'),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(
                                                          Color.fromARGB(206, 204, 83, 74)),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.lightBlue)),
                                                onPressed: () {
                                                  final updateStatus = ContractGroupCubit();
                                                  updateStatus.updateStatus(
                                                    widget.contractGroupId,
                                                    ContractGroup(
                                                      id: widget.contractGroupId,
                                                      contractGroupStatusId: 11,
                                                    ),
                                                  );
                                                  widget.nextStep(1);
                                                },
                                                child: Text('Hoàn thành'),
                                              )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
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

Widget _customerText(BuildContext context, String title, TextEditingController controller,
    TextInputType keyboardType) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: 400,
            height: 35,
            child: TextField(
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.75, color: Colors.black45)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

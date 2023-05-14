// ignore_for_file: use_build_context_synchronously

import 'package:booking_car/constants.dart';
import 'package:booking_car/resources/remote/sms_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SMSVerify extends StatefulWidget {
  final String title;
  final String phoneNum;
  final Function isVerified;
  const SMSVerify(
      {super.key, required this.title, required this.phoneNum, required this.isVerified});

  @override
  State<SMSVerify> createState() => _SMSVerifyState();
}

Future<void> sendOTP(String phone) async {
  SMSService smsService = SMSService();
  bool sent = await smsService.sentOTP(phone);
  if (sent) {
    EasyLoading.showSuccess('Gửi mã OTP thành công');
    EasyLoading.dismiss();
  } else {
    EasyLoading.showError('Gửi mã OTP thất bại');
    EasyLoading.dismiss();
  }
}

class _SMSVerifyState extends State<SMSVerify> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: Container(),
        ),
        ElevatedButton(
          onPressed: () async {
            sendOTP(widget.phoneNum);
            bool verified = await _showVerifyOTP(context, widget.phoneNum);
            if (verified == null) {
              EasyLoading.showError('Bạn cần xác thực để kí biên bản');
            } else if (verified == true) {
              EasyLoading.showSuccess('Xác thực thành công');
              widget.isVerified(true);
            } else {
              EasyLoading.showError('Xác thực không thành công');
            }
            EasyLoading.dismiss();
          },
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _showVerifyOTP(BuildContext context, String phone) async {
    String parsedPhoneNumber = phone.substring(0, 3) + "xxxx" + phone.substring(7, 10);

    return showDialog<dynamic>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 240,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('Xác thực số điện thoại',
                        style: TextStyle(fontSize: 24, color: primaryColor)),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Mã xác thực đã được gửi đến số điện thoại $parsedPhoneNumber',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 100,
                      height: 80,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        onTapOutside: null,
                        onChanged: (value) async {
                          if (value.length == 6) {
                            EasyLoading.show(status: 'Đang xác thực...');
                            SMSService sms = SMSService();
                            bool check = await sms.verifyOTP(phone, value);
                            if (check) {
                              Navigator.pop(context, true);
                            } else {
                              EasyLoading.showError('Xác thực không thành công');
                              EasyLoading.dismiss();
                            }
                          } else if (value.length < 6 || value.length > 6) {
                            EasyLoading.showError('Mã OTP phải có 6 chữ số');
                            EasyLoading.dismiss();
                          }
                        },
                        autofocus: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 24, color: Colors.black45),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        sendOTP("0328008652");
                      },
                      child: const Text('Gửi lại mã OTP'),
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

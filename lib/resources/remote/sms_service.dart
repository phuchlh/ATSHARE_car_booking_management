import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';

const OTP = '/sendOTP';
const VERIFY_OTP = '/verifyOTP';

class SMSService {
  String splitPhone(String phone) {
    if (phone.startsWith('0')) {
      return phone.substring(1);
    } else {
      return phone;
    }
  }

  Future<bool> sentOTP(String phoneNum) async {
    try {
      if (!phoneNum.contains('0328008652')) {
        phoneNum = '0328008652';
      }
      String phoneChecked = splitPhone(phoneNum);
      final response = await DioClient.post('$OTP/$phoneChecked', phoneChecked);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<dynamic> verifyOTP(String phoneNum, String otp) async {
    try {
      if (!phoneNum.contains('0328008652')) {
        phoneNum = '0328008652';
      }
      String phoneChecked = splitPhone(phoneNum);
      final response = await DioClient.post('$VERIFY_OTP/$phoneChecked/$otp', otp);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}

import 'package:booking_car/models/user.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER = '/user';

class UserService {
  Future<String?> _getToken() async {
    return SharedPreferences.getInstance().then((value) => value.getString('accessToken'));
  }

  Future<User?> getUserIdByEmail(String email) async {
    try {
      final FlutterSecureStorage storage = FlutterSecureStorage();
      String? token = await _getToken();
      final response = await DioClient.getWithToken(
        '$USER/email/$email',
        token,
      );
      if (response.statusCode == 200) {
        User userObj = User.fromJson(response.data);
        storage.write(key: 'userID', value: userObj.id.toString());
        storage.write(key: 'staffName', value: userObj.name);
        storage.write(key: 'parkinglotID', value: userObj.parkingLotId.toString());
        storage.write(key: 'parkinglotAddress', value: userObj.parkingLot.toString());
        return User.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      throw e;
    }
  }
}

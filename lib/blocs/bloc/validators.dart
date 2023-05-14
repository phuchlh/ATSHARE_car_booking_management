class Validators {
  final LICENSE_PLATE = RegExp(r'^(([1-9][1-9]|1[1-9])A|\d{1,5})$');

  String? licensePlateValid(String plate) {
    if (!LICENSE_PLATE.hasMatch(plate)) {
      return 'Nhập lại biển số xe';
      // ignore: unnecessary_null_comparison
    } else if (plate == null || plate.isEmpty) {
      return null;
    } else {
      return null;
    }
  }

  String? speedoValid(int inputSpeedo, int prevSpeedo) {
    if (inputSpeedo < prevSpeedo) {
      return 'Số km hiện tại không thể nhỏ hơn số km trước đó';
    } else if (inputSpeedo == 0) {
      return 'Số km hiện tại không thể bằng 0';
    } else {
      return null;
    }
  }

  String? fuelPercentageValid(int curFuel) {
    if (curFuel > 100) {
      return 'Phần trăm nhiên liệu từ 0 đến 100';
    } else {
      return null;
    }
  }

  String? etcAmountValid(int etc) {
    if (etc < 0) {
      return 'Số dư ETC không thể nhỏ hơn 0';
    } else {
      return null;
    }
  }
}

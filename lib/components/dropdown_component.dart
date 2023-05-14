import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_info/car_info_cubit.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> items = [];
String? selectedMake;
String? selectedSeat;
String? selectedStatus;
String hint = 'Lựa chọn';

class DropdownComponent extends StatefulWidget {
  final Function? setSelectedMake;
  final Function? setSelectedSeat;
  final Function? setSelectedStatus;
  final bool isCarMake;
  final bool isStatus;
  List<String> listData;
  String title;
  DropdownComponent({
    super.key,
    required this.isCarMake,
    required this.isStatus,
    this.setSelectedMake,
    this.setSelectedStatus,
    this.setSelectedSeat,
    required this.title,
    required this.listData,
  });

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  late bool _isCarMake;
  late bool _isStatus;
  @override
  void initState() {
    _isCarMake = widget.isCarMake;
    _isStatus = widget.isStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.title),
          DropdownButtonHideUnderline(
            child: CustomDropdownButton2(
              dropdownHeight: 300,
              hint: hint,
              dropdownItems: widget.listData,
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              value: _isCarMake == true
                  ? selectedMake
                  : _isStatus == true
                      ? selectedStatus
                      : selectedSeat,
              onChanged: (title) {
                _isCarMake == true
                    ? widget.setSelectedMake!(title)
                    : _isStatus == true
                        ? widget.setSelectedStatus!(title)
                        : widget.setSelectedSeat!(title);
                setState(() {
                  // bug chỗ này
                  _isCarMake == true
                      ? selectedMake = title
                      : _isStatus == true
                          ? selectedStatus = title
                          : selectedSeat = title;
                });
              },
              buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,
            ),
          ),
        ],
      ),
    );
  }
}

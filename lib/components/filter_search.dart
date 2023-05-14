import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_info/car_info_cubit.dart';
import 'package:booking_car/components/dropdown_component.dart';
import 'package:booking_car/models/car_info.dart';
import 'package:booking_car/screens/home/components/dropdown_filter.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filter_dialog/flutter_filter_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_component.dart' as drop;

String? selectedMake;
String? selectedStatus;
String? selectedSeat;

List<String> items = [];
List<String> itemStatus = [];
List<String> listSeat = ['4', '5', '7'];
List<CarInfo> listStatusO = [];

class FilterSearch extends StatefulWidget {
  const FilterSearch({super.key});

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

List<String> _convertObjectToString(List<CarInfo> carMake) {
  items = [];
  for (int i = 0; i < carMake.length; i++) {
    items.add(carMake[i].name!);
  }
  return items;
}

List<String> _convertStatus(List<CarInfo> listStatus) {
  listStatusO = listStatus;
  itemStatus = [];
  for (int i = 0; i < listStatus.length; i++) {
    itemStatus.add(listStatus[i].name!);
  }
  return itemStatus;
}

class _FilterSearchState extends State<FilterSearch> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showFilterDialog(context);
      },
      icon: const Icon(Icons.filter_list_sharp),
    );
  }

  void setSelectedMake(String valueMake) {
    setState(() {
      selectedMake = valueMake;
    });
  }

  void setSelectStatus(String valueStatus) {
    setState(() {
      selectedStatus = valueStatus;
    });
  }

  void setSelectedSeat(String valueSeat) {
    setState(() {
      selectedSeat = valueSeat;
    });
  }

  int checkStatus(String status, List<CarInfo> listStatus) {
    print(listStatus.length);
    for (int i = 0; i < listStatus.length; i++) {
      if (listStatus[i].name == status) {
        return listStatus[i].id!;
      }
    }
    return 0;
  }

  Future<void> showFilterDialog(BuildContext context) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bộ lọc tìm kiếm'),
          content: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // status
                BlocBuilder<InfoCubit, InfoState>(builder: (context, state) {
                  return DropdownComponent(
                    isStatus: true,
                    isCarMake: false,
                    setSelectedStatus: setSelectStatus,
                    listData: _convertStatus(state.carStatus),
                    title: 'Trạng thái',
                  );
                }),
                // hãng xe
                BlocBuilder<InfoCubit, InfoState>(builder: (context, state) {
                  return DropdownComponent(
                    isStatus: false,
                    isCarMake: true,
                    setSelectedMake: setSelectedMake,
                    listData: _convertObjectToString(state.carMake),
                    title: 'Hãng xe',
                  );
                }),
                // số chỗ
                DropdownComponent(
                  isStatus: false,
                  isCarMake: false,
                  setSelectedSeat: setSelectedSeat,
                  listData: listSeat,
                  title: 'Số chỗ ngồi',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(-1);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xóa bộ lọc'),
              onPressed: () {
                setSelectedMake("");
                setSelectedSeat("");
                setSelectStatus("");
                drop.selectedSeat = null;
                drop.selectedStatus = null;
                drop.selectedMake = null;
                context.read<CarCubit>().getAllCar(1, 100);
                Navigator.of(context).pop(-1);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Áp dụng'),
              onPressed: () {
                selectedStatus == null
                    ? selectedStatus = ""
                    : selectedStatus = selectedStatus;
                context.read<CarCubit>().searchCar(
                    statusID: checkStatus(selectedStatus!, listStatusO),
                    carMakeName: selectedMake,
                    seat: selectedSeat);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

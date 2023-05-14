// import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
// import 'package:booking_car/components/cicular_loading.dart';
// import 'package:booking_car/models/car_info.dart';
// import 'package:booking_car/screens/home/components/grid_car.dart';
// import 'package:dropdown_button2/custom_dropdown_button2.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// List<String> items = [];
// String? selectedValue;

// class Dropdown extends StatefulWidget {
//   const Dropdown({super.key, required this.listStatus});
//   final List<CarInfo> listStatus;

//   @override
//   State<Dropdown> createState() => _DropdownState();
// }

// List<String> convertObjectToString(List<CarInfo> listStatus) {
//   items = [];
//   for (int i = 0; i < listStatus.length; i++) {
//     items.add(listStatus[i].name!);
//   }
//   return items;
// }

// class _DropdownState extends State<Dropdown> {
//   Future<void> _refresh(int status) async {
//     switch (status) {
//       case 1:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 2:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 3:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 4:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 5:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 6:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 7:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 8:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 9:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       case 10:
//         await context.read<CarCubit>().getByStatus(status);
//         break;
//       default:
//         await context.read<CarCubit>().getAllCar(1, 10);
//         break;
//     }
//   }

//   _builderWidget(int status) {
//     return BlocBuilder<CarCubit, CarState>(
//       builder: (context, state) {
//         if (CarStatus.loading == state.status) {
//           return Center(
//             child: CircularLoading(),
//           );
//         } else if (CarStatus.succcess == state.status) {
//           return CarGridView(onRefresh: () => _refresh(status));
//         }
//         return CarGridView(onRefresh: () => _refresh(status));
//       },
//     );
//   }

//   Future _getAllCar() async {
//     context.read<CarCubit>().getAllCar(1, 10);
//     _builderWidget(0);
//   }

//   Future _getCarByStatus(int status) async {
//     context.read<CarCubit>().getByStatus(status);
//     _builderWidget(status);
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     convertObjectToString(widget.listStatus);
//     return Container(
//       width: 150,
//       child: DropdownButtonHideUnderline(
//         child: CustomDropdownButton2(
//           hint: 'Vui lòng chọn',
//           dropdownItems: items,
//           buttonDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           value: selectedValue,
//           onChanged: (title) {
//             switch (title) {
//               case 'Tất cả xe':
//                 _getAllCar();
//                 break;
//               case 'Đang thẩm định':
//                 _getCarByStatus(1);
//                 break;
//               case 'Sẵn sàng để thuê':
//                 _getCarByStatus(2);
//                 break;
//               case 'Chưa sẵn sàng để thuê':
//                 _getCarByStatus(3);
//                 break;
//               case 'Đang được thuê':
//                 _getCarByStatus(4);
//                 break;
//               case 'Đang bảo hiểm':
//                 _getCarByStatus(5);
//                 break;
//               case 'Đang bảo dưỡng':
//                 _getCarByStatus(6);
//                 break;
//               case 'Đang sửa':
//                 _getCarByStatus(7);
//                 break;
//               case 'Chưa thẩm định':
//                 _getCarByStatus(8);
//                 break;
//               case 'Tới hạn bảo dưỡng':
//                 _getCarByStatus(9);
//                 break;
//               case 'Đã được đặt':
//                 _getCarByStatus(10);
//                 break;
//             }
//             setState(() {
//               selectedValue = title as String;
//             });
//           },
//           dropdownDecoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           buttonHeight: 40,
//           buttonWidth: 140,
//           itemHeight: 40,
//         ),
//       ),
//     );
//   }
// }

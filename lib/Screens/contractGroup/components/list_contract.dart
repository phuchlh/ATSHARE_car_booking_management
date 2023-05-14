import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:booking_car/components/icon_text.dart';
import 'package:intl/intl.dart';

class TableContract extends StatefulWidget {
  final Future<void> Function() reload;
  const TableContract({
    required this.reload,
    super.key,
  });

  @override
  State<TableContract> createState() => _TableContractState();
}

class _TableContractState extends State<TableContract> {
  String _parseDate(String date) {
    var dateParse = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    return dateParse.toString();
  }

  List<ContractGroup> _dataContract = [];
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractGroupCubit, ContractGroupState>(
      builder: (context, state) {
        _dataContract = state.contractGroups;
        return RefreshIndicator(
          onRefresh: widget.reload,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
              itemCount: _dataContract.length,
              itemBuilder: (context, index) {
                final contractGroupElement = _dataContract[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, contractProgress,
                        arguments: contractGroupElement.id);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 249, 250, 251), // se
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(122, 255, 255, 255).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                              child: Text(
                                '${contractGroupElement.id}.  ${contractGroupElement.customerName.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18, color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    IconText(
                                      title: 'Ngày giao',
                                      icon: Icons.calendar_today,
                                      textColor: Colors.grey,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconText(
                                      title: 'Ngày nhận',
                                      icon: Icons.calendar_today,
                                      textColor: Colors.grey,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    // địa chỉ giao, nhận tùy thuộc vào status
                                    // chưa giao thì hiện giao, chưa nhận thì hiện nhận
                                    IconText(
                                      title: 'Địa chỉ giao',
                                      icon: Icons.location_on_outlined,
                                      textColor: Colors.grey,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    IconText(
                                      title: 'Trạng thái',
                                      icon: Icons.check,
                                      textColor: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  descriptionText(
                                      _parseDate(contractGroupElement.rentFrom.toString())),
                                  Padding(padding: EdgeInsets.only(top: 14)),
                                  descriptionText(
                                      _parseDate(contractGroupElement.rentTo.toString())),
                                  Padding(padding: EdgeInsets.only(top: 14)),
                                  descriptionText(
                                      contractGroupElement.deliveryAddress ?? "Chưa cập nhật"),
                                  Padding(padding: EdgeInsets.only(top: 14)),
                                  descriptionText(contractGroupElement.contractGroupStatusName ??
                                      "Chưa cập nhật"),
                                ],
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Widget descriptionText(String text) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    ],
  );
}

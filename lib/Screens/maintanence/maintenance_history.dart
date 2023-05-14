import 'package:booking_car/blocs/cubit/maintenance/maintenance_cubit.dart';
import 'package:booking_car/components/appbar.dart';
import 'package:booking_car/components/error_dialog.dart';
import 'package:booking_car/components/row_icon_title.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/maintenance_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_car/screens/car_detail/components/car_condition.dart';

class MaintenanceList extends StatefulWidget {
  final int carId;
  const MaintenanceList({super.key, required this.carId});

  @override
  State<MaintenanceList> createState() => _MaintenanceListState();
}

class _MaintenanceListState extends State<MaintenanceList> {
  Future<void> _loadMaintenanceHistory(int carId) async {
    context.read<MaintenanceCubit>().getMaintenanceHistory(carId);
  }

  @override
  void initState() {
    _loadMaintenanceHistory(widget.carId);
    super.initState();
  }

  String checkUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {
      return ERROR_PHOTO;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch sử bảo dưỡng',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MaintenanceCubit, MaintenanceState>(
          builder: (context, state) {
            if (state.status == MaintenanceStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == MaintenanceStatus.error) {
              return Center(
                child: Text('Lỗi'),
              );
            } else if (state.status == MaintenanceStatus.succcess) {
              if (state.maintenanceHistory.isEmpty) {
                return Center(
                  child: Text('Không có dữ liệu'),
                );
              } else {
                print('maintenance history: ${state.maintenanceHistory}');
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        String imageUrl = checkUrl(
                            state.maintenanceHistory[index].maintenanceInvoice?.toString() ?? "");
                        MaintenanceHistory maintenanceIndex = state.maintenanceHistory[index];
                        return GestureDetector(
                          onTap: () {
                            print('tap');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white70, // se
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(top: 20)),
                                      RowIconTitle(
                                        title: '123',
                                        data: (maintenanceIndex.kmTraveled).toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RowIconTitle(
                                        title: '123',
                                        data: (maintenanceIndex.kmTraveled).toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RowIconTitle(
                                        title: '121231233',
                                        data: (maintenanceIndex.kmTraveled).toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RowIconTitle(
                                        title: '123',
                                        data: (maintenanceIndex.kmTraveled).toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: state.maintenanceHistory.length),
                );
              }
            } else {
              return DialogConfirm(
                title: 'Đã có lỗi',
                content: 'Phát sinh lỗi trong quá trình xử lý, vui lòng thử lại trong giây lát',
              );
            }
          },
        ),
      ),
    );
  }
}

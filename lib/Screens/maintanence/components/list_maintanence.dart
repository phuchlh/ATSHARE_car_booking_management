import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/maintenance/maintenance_cubit.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/screens/maintanence/maintanence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:booking_car/screens/home/components/shimmer_grid_car.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:booking_car/constants.dart';

class ListMaintenance extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadingMore;
  const ListMaintenance({super.key, required this.onRefresh, required this.onLoadingMore});

  @override
  State<ListMaintenance> createState() => _ListMaintenanceState();
}

class _ListMaintenanceState extends State<ListMaintenance> {
  final bool _loadMore = true;
  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      isLoading: _loadMore,
      onEndOfPage: widget.onLoadingMore,
      child: RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: BlocBuilder<MaintenanceCubit, MaintenanceState>(builder: (context, state) {
          final carMaintenances = state.carMaintenances; // danh sách xe cần bảo trì
          final allCarMaintenances = state.allCarMaintenances; // danh sách tất cả xe cần bảo trì
          if (state.carMaintenances.isEmpty && MaintenanceStatus.loading == state.status) {
            return ShimmerGrid();
          } else {
            if (carMaintenances.isEmpty || allCarMaintenances.isEmpty) {
              return Center(
                child: Text('Không có dữ liệu, mời thử lại'),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  itemCount: carMaintenances.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    String imageUrl = allCarMaintenances[index].frontImg.toString();
                    String licensePlate = allCarMaintenances[index].carLicensePlates.toString();
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, carDetailPage, arguments: {
                          'id': allCarMaintenances[index].id,
                          "reload": () => widget.onRefresh
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white70, // se
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(118, 158, 158, 158).withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                height: 140,
                                width: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: imageUrl.startsWith("http")
                                          ? CachedNetworkImageProvider(imageUrl.toString())
                                          : CachedNetworkImageProvider(ERROR_PHOTO),
                                      onError: (exception, stackTrace) {
                                        print('loi load hinh ne');
                                        setState(() {
                                          allCarMaintenances[index].frontImg = ERROR_PHOTO;
                                        });
                                      },
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Icon(
                                      Icons.car_rental_outlined,
                                      size: 20,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5)),
                                    Text(
                                      allCarMaintenances[index].modelName.toString(),
                                      // "Model",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Icon(
                                      Icons.airline_seat_recline_normal_outlined,
                                      size: 20,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5)),
                                    Text(
                                      allCarMaintenances[index].seatNumber.toString(),
                                      // "Model",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5)),
                                    Text(
                                      allCarMaintenances[index].modelYear.toString(),
                                      // "Model",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Icon(
                                      Icons.color_lens_outlined,
                                      size: 20,
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5)),
                                    Text(
                                      allCarMaintenances[index].carColor.toString(),
                                      // "Model",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.555,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          // split from 69A69696 to 69A-69696
                                          // listCars[index]
                                          //     .carLicensePlates
                                          //     .toString(),
                                          '${licensePlate.substring(0, 3)}-${licensePlate.substring(3)}',

                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        }),
      ),
    );
  }
}

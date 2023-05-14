import 'dart:async';

import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/components/cicular_loading.dart';
import 'package:booking_car/components/spacing_line.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/car.dart';
import 'package:booking_car/router/router_constant.dart';
import 'package:booking_car/screens/home/components/shimmer_grid_car.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CarListView extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadingMore;
  const CarListView({
    Key? key,
    required this.onLoadingMore,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<CarListView> createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  List<Car> carsLoad = [];
  bool _loadMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    carsLoad.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      isLoading: _loadMore,
      scrollOffset: 100,
      scrollDirection: Axis.vertical,
      onEndOfPage: () {
        setState(() {
          _loadMore = true;
        });
        widget.onLoadingMore();
        setState(() {
          _loadMore = false;
        });
      },
      child: RefreshIndicator(
        onRefresh: () {
          carsLoad.clear();
          return widget.onRefresh();
        },
        child: BlocBuilder<CarCubit, CarState>(builder: (context, state) {
          carsLoad = state.allCars;
          if (CarStatus.loading == state.status) {
            return CircularLoading();
          } else if (CarStatus.error == state.status) {
            return Center(
              child: Text('Không có dữ liệu, mời thử lại'),
            );
          } else {
            final listCars = state.allCars;
            debugPrint('listCars render ${listCars.length}');
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                itemCount: listCars.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (context, index) {
                  String imageUrl = listCars[index].frontImg.toString();
                  if (!imageUrl.startsWith('http') || !imageUrl.startsWith('https')) {
                    imageUrl = ERROR_PHOTO;
                  } else {
                    imageUrl = listCars[index].frontImg.toString();
                  }
                  String licensePlate = listCars[index].carLicensePlates.toString();
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, carDetailPage,
                          arguments: {'id': listCars[index].id, "reload": () => widget.onRefresh});
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.19,
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
                        ],
                      ),
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
                                    image: CachedNetworkImageProvider(
                                      imageUrl,
                                      errorListener: () {
                                        NetworkImage(ERROR_PHOTO);
                                      },
                                    ),
                                    onError: (exception, stackTrace) {
                                      NetworkImage(ERROR_PHOTO);
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
                                    listCars[index].modelName.toString(),
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
                                    listCars[index].seatNumber.toString(),
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
                                    listCars[index].modelYear.toString(),
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
                                    listCars[index].carColor.toString(),
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Icon(
                                    Icons.arrow_right_outlined,
                                    size: 20,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    listCars[index].carStatus.toString(),
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
        }),
      ),
    );
  }
}

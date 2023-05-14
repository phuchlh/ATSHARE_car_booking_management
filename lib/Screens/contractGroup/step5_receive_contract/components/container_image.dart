import 'package:booking_car/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  final String? setFront;
  final String? setBack;
  final String? setLeft;
  final String? setRight;
  final String? setInside;
  final String? setDashboard;
  final String? setPhysicalDamage;
  const ContainerImage({
    Key? key,
    this.setFront,
    this.setBack,
    this.setLeft,
    this.setRight,
    this.setInside,
    this.setDashboard,
    this.setPhysicalDamage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgDescription = [
      'Ảnh xe trước',
      'Ảnh xe sau',
      'Ảnh xe bên trái',
      'Ảnh xe bên phải',
      'Ảnh nội thất',
      'Ảnh ghế sau',
    ];
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              scale: 0.5,
                              image: CachedNetworkImageProvider(
                                setFront == '' ? ERROR_PHOTO : setFront!,
                              ),
                              onError: (exception, stackTrace) {
                                CachedNetworkImageProvider(
                                  ERROR_PHOTO,
                                );
                              },
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imgDescription[0].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 32)),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              scale: 0.5,
                              image: CachedNetworkImageProvider(
                                setBack == '' ? ERROR_PHOTO : setBack!,
                              ),
                              onError: (exception, stackTrace) {
                                CachedNetworkImageProvider(
                                  ERROR_PHOTO,
                                );
                              },
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imgDescription[1].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              scale: 0.5,
                              image: CachedNetworkImageProvider(
                                setLeft == '' ? ERROR_PHOTO : setLeft!,
                              ),
                              onError: (exception, stackTrace) {
                                CachedNetworkImageProvider(
                                  ERROR_PHOTO,
                                );
                              },
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imgDescription[2].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 32)),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              scale: 0.5,
                              image: CachedNetworkImageProvider(
                                setRight == '' ? ERROR_PHOTO : setRight!,
                              ),
                              onError: (exception, stackTrace) {
                                CachedNetworkImageProvider(
                                  ERROR_PHOTO,
                                );
                              },
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imgDescription[3].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              scale: 0.5,
                              image: CachedNetworkImageProvider(
                                setInside == '' ? ERROR_PHOTO : setInside!,
                              ),
                              onError: (exception, stackTrace) {
                                CachedNetworkImageProvider(
                                  ERROR_PHOTO,
                                );
                              },
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imgDescription[4].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Column(
              //     children: [
              //       Container(
              //         width: 250.0,  
              //         height: 300.0,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10.0),
              //             image: DecorationImage(
              //                 scale: 2.0,
              //                 image: CachedNetworkImageProvider(
              //                   setPhysicalDamage == ''
              //                       ? ERROR_PHOTO
              //                       : setPhysicalDamage!,
              //                 ),
              //                 onError: (exception, stackTrace) {
              //                   CachedNetworkImageProvider(
              //                     ERROR_PHOTO,
              //                   );
              //                 },
              //                 fit: BoxFit.cover)),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           imgDescription[5].toString(),
              //           style: TextStyle(
              //             fontWeight: FontWeight.w500,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

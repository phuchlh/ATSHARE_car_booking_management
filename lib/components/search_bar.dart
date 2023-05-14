import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .75,
      child: TextField(
        onSubmitted: context.read<CarCubit>().onChangeSearchString,
        decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          hintText: 'Tìm theo biển số ...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

import 'package:booking_car/blocs/cubit/maintenance/maintenance_cubit.dart';
import 'package:booking_car/screens/maintanence/components/list_maintanence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:booking_car/components/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int page = 1;

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  Future<void> _loadMaintenance() async {
    context.read<MaintenanceCubit>().getAllCarNeedMaintenance();
  }

  Future<void> _loadMore() async {
    page++;
    context.read<MaintenanceCubit>().getMoreCarNeedMaintenance(page);
  }

  @override
  void initState() {
    _loadMaintenance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            CustomAppBar(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Expanded(
              child: ListMaintenance(
                onRefresh: _loadMaintenance,
                onLoadingMore: _loadMore,
              ),
            )
          ],
        ),
      ),
    );
  }
}

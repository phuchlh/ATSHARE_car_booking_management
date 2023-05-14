import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/components/appbar.dart';
import 'package:booking_car/components/filter_search.dart';
import 'package:booking_car/components/search_bar.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/screens/contractGroup/components/list_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Contract extends StatefulWidget {
  const Contract({super.key});

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  Future<void> _loadData() async {
    context.read<ContractGroupCubit>().getAllContractGroup();
  }

  Future<void> load() async {
    await _loadData();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideBar(),

      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: TableContract(reload: _loadData),
            ),
          ],
        ),
      ),
    );
  }
}

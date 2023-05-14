import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentalRequest extends StatefulWidget {
  final int contractGroupId;
  const RentalRequest({super.key, required this.contractGroupId});

  @override
  State<RentalRequest> createState() => _RentalRequestState();
}

class _RentalRequestState extends State<RentalRequest> {
  Future<void> _loadById(int id) async {
    context.read<ContractGroupCubit>().getContractGroup(id);
  }

  @override
  void initState() {
    _loadById(widget.contractGroupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('RentalRequest'),
        ],
      ),
    );
  }
}

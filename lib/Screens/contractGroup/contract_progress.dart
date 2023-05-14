// import 'package:booking_car/screens/entryPoint/components/side_bar.dart';
import 'package:booking_car/Screens/contractGroup/step5_receive_contract/receive_contract.dart';
import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/screens/contractGroup/step_4_transfer_contract/transfer_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressTracking extends StatefulWidget {
  final int contractGroupId;
  const ProgressTracking({super.key, required this.contractGroupId});

  @override
  State<ProgressTracking> createState() => _ProgressTrackingState();
}

class _ProgressTrackingState extends State<ProgressTracking> {
  late int currentStep;
  late int status;
  ContractGroupCubit bloc = ContractGroupCubit();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _loadContractDetail(int contractGroupId) async {
    bloc = context.read<ContractGroupCubit>();
    bloc.getContractGroup(contractGroupId);
  }

  int _switchCurrStep(int status) {
    switch (status) {
      case -1:
        return -1;
      case 1:
        return -1;
      case 2:
        return -1;
      case 3:
        return -1;
      case 4:
        return -1;
      case 5:
        return -1;
      case 6:
        return -1;
      case 7:
        currentStep = 0;
        return 0;
      case 8:
        currentStep = 0;
        return 0;
      case 9:
        currentStep = 0;
        return 0;
      case 10:
        currentStep = 0;
        return 0;
      case 11:
        currentStep = 1;
        return 1;
      case 12:
        currentStep = 1;
        return 1;
      case 13:
        currentStep = 1;
        return 1;
      case 14:
        return -1;
      case 15:
        currentStep = 0;
        return 0;
      case 16:
        currentStep = 1;
        return 1;
      default:
        currentStep = 0;
        return 0;
    }
  }

  // _setCurrentStep(int step) {
  //   _loadContractDetail(widget.contractGroupId);
  //   setState(() {
  //     status = bloc.state.contractGroup?.contractGroupStatusId ?? 0;
  //     if (status != 0) {
  //       // status = 11;
  //       _switchCurrStep(status);
  //       // currentStep = step;
  //     }
  //   });
  //   print('status progress tracking: $status');
  // }

  _setCurrentStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  _reloadStep(int step) {
    setState(() {
      currentStep = step;
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      _loadContractDetail(widget.contractGroupId);
    });
  }

  _changeStep2(int step) {
    setState(() {
      currentStep = step;
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      _loadContractDetail(widget.contractGroupId);
    });
  }

  @override
  void initState() {
    status = 0;
    currentStep = 0;
    // _callApi();
    _loadContractDetail(widget.contractGroupId);
    // _checkCurrentStep(bloc.state.contractGroup?.contractGroupStatusId ?? 0);
    // nhảy
    _switchCurrStep(bloc.state.contractGroup?.contractGroupStatusId ?? 0);
    super.initState();
  }

  Map<List<int>, int> _mapStatusWithStep() {
    return {
      // [1, 2]: 0,
      // [3, 4]: 1,
      [7]: 0,
      [8, 9, 10]: 0,
      [11, 12, 13]: 1,
    };
  }

  void _checkCurrentStep(int status) {
    _mapStatusWithStep().forEach((key, value) {
      if (key.contains(status)) {
        _switchCurrStep(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContractGroupCubit, ContractGroupState>(
        builder: ((context, state) {
          // _checkCurrentStep(state.contractGroup?.contractGroupStatusId ?? 0);
          // currentStep = _switchCurrStep(state.contractGroup?.contractGroupStatusId ?? 0);
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _loadContractDetail(widget.contractGroupId),
              child: Stepper(
                onStepTapped: (value) {
                  _setCurrentStep(value);
                },
                physics: ClampingScrollPhysics(),
                steps: getSteps(),
                type: StepperType.horizontal,
                currentStep: currentStep,
                // currentStep: currContract,
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Step> getSteps() => [
        // giao xe
        Step(
            state: currentStep >= 0 ? StepState.complete : StepState.indexed,
            subtitle: Text('Giao xe'),
            title: Text('Bước 4'),
            content: BlocBuilder<ContractGroupCubit, ContractGroupState>(
              builder: ((context, state) {
                return TransferContract(
                  carState: CarState(),
                  reloadStep: _loadContractDetail,
                  nextStep: _changeStep2,
                  contractGroup: state.contractGroup,
                  contractGroupId: widget.contractGroupId,
                  status: state.contractGroup?.contractGroupStatusId ?? 8,
                );
              }),
            ),
            isActive: currentStep >= 0),
        // trả xe
        Step(
            state: currentStep >= 1 ? StepState.complete : StepState.indexed,
            subtitle: Text('Nhận xe'),
            title: Text('Bước 5'),
            content: BlocBuilder<ContractGroupCubit, ContractGroupState>(
              builder: (context, state) {
                return ReceiveContractScreen(
                  reloadStep: _loadContractDetail,
                  contractGroup: state.contractGroup,
                  contractGroupId: widget.contractGroupId,
                  status: state.contractGroup?.contractGroupStatusId ?? -1,
                );
              },
            ),
            isActive: currentStep >= 1),
      ];
}

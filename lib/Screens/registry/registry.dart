import 'package:booking_car/blocs/cubit/registry/registry_cubit.dart';
import 'package:booking_car/components/appbar.dart';
import 'package:booking_car/screens/maintanence/components/list_maintanence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/list_registry.dart';

int page = 1;

class RegistryScreen extends StatefulWidget {
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  Future<void> _loadRegistry() async {
    context.read<RegistryCubit>().getAllCarNeedRegistry(1);
  }

  Future<void> _loadMore() async {
    page++;
    context.read<RegistryCubit>().getMoreCarNeedRegistry(page);
  }

  @override
  void initState() {
    _loadRegistry();
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
              child: ListRegistry(
                onRefresh: _loadRegistry,
                onLoadingMore: _loadMore,
              ),
            )
          ],
        ),
      ),
    );
  }
}

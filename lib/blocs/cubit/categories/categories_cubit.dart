import 'package:bloc/bloc.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/models/contract_group_status.dart';
import 'package:booking_car/resources/interfaces/i_categories_repository.dart';
import 'package:booking_car/resources/remote/categories_service.dart';

import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({ICategoriesRepository? categoriesService})
      : _categoriesService = categoriesService ?? CategoriesService.instance,
        super(CategoriesState());

  late ICategoriesRepository _categoriesService;

  Future<void> loadCategories() async {
    try {
      emit(state.copyWith(loadingState: LoadingState.loading));
      final listContractGroupStatusResult =
          await _categoriesService.getListContractGroupStatus();

      if (listContractGroupStatusResult != null) {
        emit(state.copyWith(
          loadingState: LoadingState.success,
          listContractGroupStatus: listContractGroupStatusResult,
        ));
      } else {
        emit(state.copyWith(loadingState: LoadingState.failed));
      }
    } on Exception catch (e) {
      emit(state.copyWith(loadingState: LoadingState.failed));
    }
  }
}

import 'package:booking_car/models/contract_group_status.dart';

abstract class ICategoriesRepository {
  Future<List<ContractGroupStatus>?> getListContractGroupStatus();
}

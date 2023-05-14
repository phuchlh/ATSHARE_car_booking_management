import 'package:booking_car/models/contract_group_status.dart';
import 'package:booking_car/resources/dio.dart';
import 'package:booking_car/resources/interfaces/i_categories_repository.dart';

class CategoriesService extends ICategoriesRepository {
  CategoriesService._privateConstructor();
  static final CategoriesService _instance =
      CategoriesService._privateConstructor();
  static CategoriesService get instance => _instance;

  @override
  Future<List<ContractGroupStatus>?> getListContractGroupStatus() async {
    try {
      final response = await DioClient.get("/contractgroupstatus");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map<ContractGroupStatus>((e) => ContractGroupStatus.fromJson(e))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

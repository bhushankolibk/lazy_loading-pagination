import 'package:flutter/cupertino.dart';
import 'package:pagination/app_constant/common_fun.dart';
import 'package:pagination/model/model_pagintion.dart';
import 'package:pagination/services/web_service.dart';

class VMPagination with ChangeNotifier {
  ModelPagination paginatedData;
  List<PaginationData> paginatedList = [];
  requestResponseState responseState = requestResponseState.Loading;

  Future<void> getPaginatedList({
    int pageNo,
    bool isRefresh = false,
  }) async {
    String url = "https://reqres.in/api/users?per_page=5&page=$pageNo";
    try {
      responseState = requestResponseState.Loading;
      var resData = await getRequest(url: url);
      if (isRefresh) paginatedList.clear();
      if (isRefresh) paginatedData = null;
      paginatedData = modelPaginationFromJson(resData);

      paginatedList.addAll(paginatedData.data);
      responseState = requestResponseState.DataReceived;
      notifyListeners();
    } catch (error) {
      responseState = requestResponseState.Error;
      notifyListeners();
      throw error;
    }
  }
}

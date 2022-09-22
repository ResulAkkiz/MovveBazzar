import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/services/json_place_service.dart';

class TrendingViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<IBaseTrendingModel> trendingModelList = [];
  List<IBaseTrendingModel> popularModelList = [];
  final JsonPlaceService _jsonPlaceService = JsonPlaceService();

  Future<void> getTrendings({
    required String type,
    required String timeInterval,
    required String pageNumber,
  }) async {
    isLoading = true;
    trendingModelList = await _jsonPlaceService.getTrendings(
      type: type,
      timeInterval: timeInterval,
      pageNumber: pageNumber,
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTvPopulars({required String pageNumber}) async {
    isLoading = true;
    popularModelList =
        await _jsonPlaceService.getTvPopulars(pageNumber: pageNumber);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMoviePopulars({required String pageNumber}) async {
    isLoading = true;
    popularModelList =
        await _jsonPlaceService.getMoviePopulars(pageNumber: pageNumber);
    isLoading = false;
    notifyListeners();
  }
}

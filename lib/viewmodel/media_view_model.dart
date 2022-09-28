import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/services/json_place_service.dart';

class MediaViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<IBaseTrendingModel> trendingModelList = [];
  List<TvTrending> popularTvModelList = [];
  List<MovieTrending> popularMovieModelList = [];
  final JsonPlaceService _jsonPlaceService = JsonPlaceService();

  Future<List<IBaseTrendingModel>> getTrendings({
    required String type,
    required String timeInterval,
    required int pageNumber,
  }) async {
    isLoading = true;
    final List<IBaseTrendingModel> tempTrendingModelList =
        await _jsonPlaceService.getTrendings(
      type: type,
      timeInterval: timeInterval,
      pageNumber: pageNumber,
    );
    if (pageNumber == 1 && type == 'all' && timeInterval == 'day') {
      trendingModelList = tempTrendingModelList;
    }
    isLoading = false;
    notifyListeners();
    return tempTrendingModelList;
  }

  Future<List<TvTrending>> getTvPopulars({required int pageNumber}) async {
    isLoading = true;
    final List<TvTrending> tempPopularTvModelList =
        await _jsonPlaceService.getTvPopulars(pageNumber: pageNumber);
    if (pageNumber == 1) {
      popularTvModelList = tempPopularTvModelList;
    }
    isLoading = false;
    notifyListeners();
    return tempPopularTvModelList;
  }

  Future<List<MovieTrending>> getMoviePopulars(
      {required int pageNumber}) async {
    isLoading = true;

    final List<MovieTrending> tempPopularMovieModelList =
        await _jsonPlaceService.getMoviePopulars(pageNumber: pageNumber);
    if (pageNumber == 1) {
      popularMovieModelList = tempPopularMovieModelList;
    }
    isLoading = false;
    notifyListeners();
    return tempPopularMovieModelList;
  }
}

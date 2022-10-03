import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/services/json_place_service.dart';
import 'package:flutter_application_1/services/media_images_model.dart';

class MediaViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<IBaseTrendingModel> trendingModelList = [];
  List<IBaseTrendingModel> discoverTvModelList = [];
  List<IBaseTrendingModel> discoverMovieModelList = [];
  List<TvTrending> popularTvModelList = [];
  List<MovieTrending> popularMovieModelList = [];
  List<PeopleCast> peopleCastList = [];
  List<MediaImage>? mediaImageList = [];
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

  Future<void> getDiscovers({
    required String type,
    required int pageNumber,
  }) async {
    isLoading = true;
    if (type == 'movie') {
      discoverMovieModelList = await _jsonPlaceService.getDiscovers(
        type: type,
        pageNumber: pageNumber,
      );
      notifyListeners();
      isLoading = false;
    } else {
      discoverTvModelList = await _jsonPlaceService.getDiscovers(
        type: type,
        pageNumber: pageNumber,
      );
      notifyListeners();
      isLoading = false;
    }
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

  Future<Movie> getMoviebyID(int movieID) async {
    return await _jsonPlaceService.getMoviebyID(movieID);
  }

  Future<void> getCastbyMovieIds(int movieID) async {
    peopleCastList = await _jsonPlaceService.getCastbyMovieId(movieID);
    notifyListeners();
  }

  Future<void> getMediaImagebyMediaID(int mediaID, String type) async {
    switch (type) {
      case 'tv':
        mediaImageList = await _jsonPlaceService.getTvImagebyMediaIDs(mediaID);
        notifyListeners();
        break;
      case 'movie':
        mediaImageList =
            await _jsonPlaceService.getMovieImagebyMediaIDs(mediaID);
        notifyListeners();
        break;

      default:
    }
  }
}

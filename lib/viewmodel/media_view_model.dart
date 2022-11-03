import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';
import 'package:flutter_application_1/model/genre_model.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/people_trending_model.dart';
import 'package:flutter_application_1/model/review_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/services/json_place_service.dart';

class MediaViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<IBaseTrendingModel> trendingModelList = [];
  List<IBaseTrendingModel> discoverTvModelList = [];
  List<IBaseTrendingModel> discoverMovieModelList = [];
  List<TvTrending> popularTvModelList = [];
  List<MovieTrending> popularMovieModelList = [];
  List<PeopleCast> peopleCastList = [];
  List<MediaBase> mediaList = [];
  List<Review> reviewList = [];
  List<MovieTrending> similiarMovieList = [];
  List<TvTrending> similiarTvList = [];
  List<Genre> tvGenreList = [];
  List<Genre> movieGenreList = [];
  List<IBaseTrendingModel>? queryResultList = [];
  List<TvTrending> queryTvList = [];
  List<MovieTrending> queryMovieList = [];
  List<PeopleTrending> queryPeopleList = [];
  List<CastCredit> castCreditList = [];
  Set<String> genreNameList = {};

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

  Future<IBaseTrendingShowModel?> getRandomTrendingMedia() async {
    List<String> mediaList = ['tv', 'movie'];
    mediaList.shuffle();

    int randomPage = Random().nextInt(20) + 1;
    int randomIndex = Random().nextInt(20);
    try {
      if (tvGenreList.isEmpty) {
        await getTvGenre();
      }

      if (movieGenreList.isEmpty) {
        await getMovieGenre();
      }

      final List<IBaseTrendingModel> tempTrendingModelList =
          await _jsonPlaceService.getTrendings(
        type: mediaList.first,
        timeInterval: 'day',
        pageNumber: randomPage,
      );
      IBaseTrendingModel randomMedia = tempTrendingModelList[randomIndex];

      if (randomMedia.mediaType == 'tv' || randomMedia.mediaType == 'movie') {
        List<Genre> genreList =
            randomMedia.mediaType == 'tv' ? tvGenreList : movieGenreList;

        randomMedia as IBaseTrendingShowModel;

        genreList.removeWhere((e) => e.name == null);
        genreNameList = genreList
            .where((value) => randomMedia.genreIds?.contains(value.id) ?? false)
            .map((e) => e.name!)
            .toSet();
      } else {
        genreNameList.clear();
      }

      return randomMedia as IBaseTrendingShowModel;
    } on Exception catch (e) {
      debugPrint('Error in getting random media : ${e.toString()}');
      return null;
    }
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

  Future<IBaseModel> getDetailbyID(int movieID, String type) async {
    return await _jsonPlaceService.getDetailbyIDs(movieID, type);
  }

  Future<void> getCastbyMediaIDs(int movieID, String type) async {
    peopleCastList = await _jsonPlaceService.getCastbyMediaIDs(movieID, type);
    notifyListeners();
  }

  Future<List<MediaBase>> getMediasbyMediaID(int mediaID, String type) async {
    mediaList = [];
    List<MediaImage>? imageList = [];
    List<MediaImage>? taggedImageList = [];
    List<MediaVideo>? videoList = [];
    switch (type) {
      case 'tv':
        videoList = await _jsonPlaceService.getTvVideobyMediaIDs(mediaID);
        imageList = await _jsonPlaceService.getTvImagebyMediaIDs(mediaID);
        break;
      case 'movie':
        videoList = await _jsonPlaceService.getMovieVideobyMediaIDs(mediaID);
        imageList = await _jsonPlaceService.getMovieImagebyMediaIDs(mediaID);
        break;
      case 'person':
        imageList = await _jsonPlaceService.getPersonImagebyPersonIDs(mediaID);
        taggedImageList =
            await _jsonPlaceService.getTaggedImagesbyPersonIDs(mediaID);
        break;
      default:
    }

    if (videoList != null) {
      mediaList.addAll(videoList);
    }
    if (imageList != null) {
      mediaList.addAll(imageList);
    }
    if (taggedImageList != null) {
      mediaList.addAll(taggedImageList);
    }

    notifyListeners();

    return mediaList;
  }

  Future<void> getReviewsbyMediaID(
    int mediaID,
    int pageNumber,
    String type,
  ) async {
    reviewList =
        await _jsonPlaceService.getReviewsbyMediaID(mediaID, pageNumber, type);
    notifyListeners();
  }

  Future<void> getSimilarMoviebyMovieIDs(int movieID) async {
    similiarMovieList =
        await _jsonPlaceService.getSimilarMoviebyMovieIDs(movieID);
    notifyListeners();
  }

  Future<void> getSimilarTvbyTvIDs(int tvID) async {
    similiarTvList = await _jsonPlaceService.getSimilarTvbyTvIDs(tvID);
    notifyListeners();
  }

  Future<void> getTvGenre() async {
    tvGenreList = await _jsonPlaceService.getTvGenre();
    notifyListeners();
  }

  Future<void> getMovieGenre() async {
    movieGenreList = await _jsonPlaceService.getMovieGenre();
    notifyListeners();
  }

  Future<void> getCastCreditbyPersonID(int personID) async {
    castCreditList = await _jsonPlaceService.getCastCreditbyPersonIDs(personID);
    print(castCreditList.length);
    notifyListeners();
  }

  Future<void> searchQueries(String? query, String? page) async {
    if (query != '') {
      List<IBaseTrendingModel>? tempList =
          await _jsonPlaceService.searchQueries(query, page);
      if (tempList != null) {
        queryResultList!.addAll(tempList);
      }
      debugPrint(
          'tempList ${tempList?.length} ,queryResultList ${queryResultList?.length} ');
    }
    queryTvList = queryResultList!.whereType<TvTrending>().toList();
    queryMovieList = queryResultList!.whereType<MovieTrending>().toList();
    queryPeopleList = queryResultList!.whereType<PeopleTrending>().toList();
    notifyListeners();
  }
}

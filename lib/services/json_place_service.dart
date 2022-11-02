import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_show_model.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';
import 'package:flutter_application_1/model/genre_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/review_model.dart';

import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/services/base_service.dart';

class JsonPlaceService extends BaseService {
  Future<List<IBaseTrendingModel>> getTrendings({
    required String type,
    required String timeInterval,
    required int pageNumber,
  }) async {
    return await getTrending(
      type: type,
      timeInterval: timeInterval,
      pageNumber: pageNumber,
    );
  }

  Future<List<TvTrending>> getTvPopulars({required int pageNumber}) async {
    return await getPopulars<TvTrending>(
        type: 'tv', pageNumber: pageNumber, model: TvTrending());
  }

  Future<List<MovieTrending>> getMoviePopulars(
      {required int pageNumber}) async {
    return await getPopulars<MovieTrending>(
        type: 'movie', pageNumber: pageNumber, model: MovieTrending());
  }

  Future<List<IBaseTrendingModel>> getDiscovers({
    required String type,
    required int pageNumber,
  }) async {
    return await getDiscover(type: type, pageNumber: pageNumber);
  }

  Future<IBaseModel> getDetailbyIDs(int detailID, String type) async {
    return await getDetailbyID(detailID, type);
  }

  Future<List<PeopleCast>> getCastbyMediaIDs(int mediaID, String type) async {
    return await getCastbyMediaID(mediaID, type);
  }

  Future<List<MediaImage>?> getMovieImagebyMediaIDs(
    int mediaID,
  ) async {
    return await getImagesbymediaID(mediaID, 'movie');
  }

  Future<List<MediaImage>?> getTvImagebyMediaIDs(
    int mediaID,
  ) async {
    return await getImagesbymediaID(mediaID, 'tv');
  }

  Future<List<MediaVideo>?> getMovieVideobyMediaIDs(
    int mediaID,
  ) async {
    return await getVideosbymediaID(mediaID, 'movie');
  }

  Future<List<MediaVideo>?> getTvVideobyMediaIDs(
    int mediaID,
  ) async {
    return await getVideosbymediaID(mediaID, 'tv');
  }

  Future<List<MediaImage>?> getPersonImagebyPersonIDs(
    int mediaID,
  ) async {
    return await getImagesbymediaID(mediaID, 'person');
  }

  Future<List<Review>> getReviewsbyMediaID(
    int mediaID,
    int pageNumber,
    String type,
  ) async {
    return await getReviewbyMediaID(
      mediaID,
      pageNumber,
      type,
    );
  }

  Future<List<MediaImage>?> getTaggedImagesbyPersonIDs(int personID) async {
    return await getTaggedImagesbyPersonID(personID);
  }

  Future<List<MovieTrending>> getSimilarMoviebyMovieIDs(int movieID) async {
    return await getSimilarMoviebyMovieID(
      movieID,
    );
  }

  Future<List<TvTrending>> getSimilarTvbyTvIDs(int tvID) async {
    return await getSimilarTvbyTvID(
      tvID,
    );
  }

  Future<List<Genre>> getTvGenre() async {
    return await getGenreList('tv');
  }

  Future<List<Genre>> getMovieGenre() async {
    return await getGenreList('movie');
  }

  Future<List<IBaseTrendingModel>?> searchQueries(
      String? query, String? page) async {
    return await searchQuery(query: query, page: page);
  }

  Future<List<CastCredit>> getCastCreditbyPersonIDs(int personID) async {
    return await getCastCreditbyPersonID(personID);
  }
}

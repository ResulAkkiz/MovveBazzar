import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/model/review_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/services/base_service.dart';
import 'package:flutter_application_1/model/media_images_model.dart';

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

  Future<Movie> getMoviebyIDs(int movieID) async {
    return await getMoviebyID(movieID);
  }

  Future<List<PeopleCast>> getCastbyMovieIds(int movieID) async {
    return await getCastbyMovieId(movieID);
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

  Future<List<Review>> getReviewsbyMediaID(
    int mediaID,
    int pageNumber,
    String type,
  ) async {
    return await getReviewsbyMediaID(
      mediaID,
      pageNumber,
      type,
    );
  }
}

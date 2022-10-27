import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/genre_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/review_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/model/type_definitions.dart';
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
        type: 'tv', pageNumber: pageNumber, model: const TvTrending());
  }

  Future<List<MovieTrending>> getMoviePopulars(
      {required int pageNumber}) async {
    return await getPopulars<MovieTrending>(
        type: 'movie', pageNumber: pageNumber, model: const MovieTrending());
  }

  Future<List<IBaseTrendingModel>> getDiscovers({
    required String type,
    required int pageNumber,
  }) async {
    return await getDiscover(type: type, pageNumber: pageNumber);
  }

  Future<IBaseModel> getMediabyIDs(Id movieID, String type) async {
    return await getMediabyID(movieID, type);
  }

  Future<List<PeopleCast>> getCastbyMediaIDs(Id mediaID, String type) async {
    return await getCastbyMediaID(mediaID, type);
  }

  Future<List<MediaImage>?> getMovieImagebyMediaIDs(
    Id mediaID,
  ) async {
    return await getImagesbymediaID(mediaID, 'movie');
  }

  Future<List<MediaImage>?> getTvImagebyMediaIDs(
    Id mediaID,
  ) async {
    return await getImagesbymediaID(mediaID, 'tv');
  }

  Future<List<MediaVideo>?> getMovieVideobyMediaIDs(
    Id mediaID,
  ) async {
    return await getVideosbymediaID(mediaID, 'movie');
  }

  Future<List<MediaVideo>?> getTvVideobyMediaIDs(
    Id mediaID,
  ) async {
    return await getVideosbymediaID(mediaID, 'tv');
  }

  Future<List<Review>> getReviewsbyMediaID(
    Id mediaID,
    int pageNumber,
    String type,
  ) async {
    return await getReviewbyMediaID(
      mediaID,
      pageNumber,
      type,
    );
  }

  Future<List<MovieTrending>> getSimilarMoviebyMovieIDs(Id movieID) async {
    return await getSimilarMoviebyMovieID(
      movieID,
    );
  }

  Future<List<TvTrending>> getSimilarTvbyTvIDs(Id tvID) async {
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
}

import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
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
}

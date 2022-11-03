import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_model.dart';
import 'package:flutter_application_1/model/base_show_model.dart';

import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/castcredit_model.dart';
import 'package:flutter_application_1/model/genre_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';

import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/people_model.dart';

import 'package:flutter_application_1/model/people_trending_model.dart';
import 'package:flutter_application_1/model/review_model.dart';

import 'package:flutter_application_1/model/tv_model.dart';

import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final baseUrl = 'https://api.themoviedb.org/3';
  final apiKey = '07f5723af6c9503db9c8ce9493c975ce';

  Future<dynamic> getPopulars<T extends IBaseTrendingModel>(
      {required String type,
      required int pageNumber,
      required IBaseTrendingModel model}) async {
    final String url =
        "$baseUrl/$type/popular?api_key=$apiKey&page=$pageNumber";
    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParser<T>(model, response.body);

      default:
        throw Exception(response.body);
    }
  }

  dynamic _jsonBodyParser<T>(IBaseTrendingModel model, String body) {
    var jsonBody = (jsonDecode(body))['results'];
    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromMap(e)).toList().cast<T>();
    } else if (jsonBody is Map<String, dynamic>) {
      return model.fromMap(jsonBody);
    } else {
      jsonBody;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<dynamic> getTrending<T extends IBaseTrendingModel>({
    required String type,
    required String timeInterval,
    required int pageNumber,
  }) async {
    final String url =
        "$baseUrl/trending/$type/$timeInterval?api_key=$apiKey&page=$pageNumber";
    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParserV2(response.body);
      default:
        throw Exception(response.body);
    }
  }

  dynamic _jsonBodyParserV2(String body) {
    var jsonBody = (jsonDecode(body))['results'];
    if (jsonBody is List) {
      List<IBaseTrendingModel> list = [];
      for (Map<String, dynamic> singleMap in jsonBody) {
        switch (singleMap["media_type"]) {
          case "movie":
            list.add(MovieTrending.fromMap(singleMap));
            break;
          case "tv":
            list.add(TvTrending.fromMap(singleMap));
            break;
          default:
            debugPrint('another type model pass here');
        }
      }
      return list;
    } else if (jsonBody is Map<String, dynamic>) {
      return _modelParser(jsonBody);
    } else {
      jsonBody;
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<dynamic> getDiscover<T extends IBaseTrendingModel>({
    required String type,
    required int pageNumber,
  }) async {
    final String url =
        "$baseUrl/discover/$type?api_key=$apiKey&page=$pageNumber";
    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParserV3(response.body, type);
      default:
        throw Exception(response.body);
    }
  }

  dynamic _jsonBodyParserV3(String body, String type) {
    var jsonBody = (jsonDecode(body))['results'];
    if (jsonBody is List) {
      List<IBaseTrendingModel> list = [];
      for (Map<String, dynamic> singleMap in jsonBody) {
        switch (type) {
          case "movie":
            list.add(MovieTrending.fromMap(singleMap));
            break;
          case "tv":
            list.add(TvTrending.fromMap(singleMap));
            break;
          default:
            debugPrint('another type model pass here');
        }
      }
      return list;
    } else if (jsonBody is Map<String, dynamic>) {
      return _modelParser(jsonBody);
    } else {
      jsonBody;
    }
  }

  void _modelParser(Map<String, dynamic> singleMap) {
    switch (singleMap["media_type"]) {
      case "movie":
        MovieTrending.fromMap(singleMap);
        break;
      case "tv":
        TvTrending.fromMap(singleMap);
        break;
      default:
        debugPrint('another type model pass here');
    }
  }

  Future<IBaseModel> getDetailbyID(int mediaID, String type) async {
    final String url = "$baseUrl/$type/$mediaID?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        switch (type) {
          case 'tv':
            return Tv.fromMap(jsonDecode(response.body));
          case 'movie':
            return Movie.fromMap(jsonDecode(response.body));
          default:
            return Person.fromMap(jsonDecode(response.body));
        }
      default:
        throw Exception(response.body);
    }
  }

  Future<Person> getPersonbyID(int personID) async {
    final String url = "$baseUrl/person/$personID?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Person.fromMap(jsonDecode(response.body));
      default:
        throw Exception(response.body);
    }
  }

  Future<List<MovieTrending>> getSimilarMoviebyMovieID(int movieID) async {
    //https: //api.themoviedb.org/3/movie/760161/similar?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/movie/$movieID/similar?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    var jsonBody = (jsonDecode(response.body))['results'];
    switch (response.statusCode) {
      case HttpStatus.ok:
        List<MovieTrending> similarMovieList = [];
        if (jsonBody is List) {
          for (Map<String, dynamic> singleMap in jsonBody) {
            similarMovieList.add(MovieTrending.fromMap(singleMap));
          }
        }
        return similarMovieList;
      default:
        throw Exception(response.body);
    }
  }

  Future<List<TvTrending>> getSimilarTvbyTvID(int tvID) async {
    //https: //api.themoviedb.org/3/movie/760161/similar?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/tv/$tvID/similar?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    var jsonBody = (jsonDecode(response.body))['results'];
    switch (response.statusCode) {
      case HttpStatus.ok:
        List<TvTrending> similarTvList = [];
        if (jsonBody is List) {
          for (Map<String, dynamic> singleMap in jsonBody) {
            similarTvList.add(TvTrending.fromMap(singleMap));
          }
        }
        return similarTvList;
      default:
        throw Exception(response.body);
    }
  }

  Future<List<PeopleCast>> getCastbyMediaID(int mediaID, String type) async {
    //https://api.themoviedb.org/3/movie/2/credits?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/$type/$mediaID/credits?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = (jsonDecode(response.body))['cast'];
        List<PeopleCast> peopleList = [];
        if (jsonBody is List) {
          for (Map<String, dynamic> singleMap in jsonBody) {
            peopleList.add(PeopleCast.fromMap(singleMap));
          }
        }

        return peopleList;
      default:
        throw Exception(response.body);
    }
  }

  Future<List<CastCredit>> getCastCreditbyPersonID(int personID) async {
    final String url =
        "$baseUrl/person/$personID/combined_credits?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = (jsonDecode(response.body))['cast'];
        List<CastCredit> castCreditList = [];
        if (jsonBody is List) {
          for (Map<String, dynamic> singleMap in jsonBody) {
            castCreditList.add(CastCredit.fromMap(singleMap));
          }
        }
        debugPrint('Baseservicedeki eleman sayısı - ${castCreditList.length}');
        return castCreditList;
      default:
        throw Exception(response.body);
    }
  }

  Future<List<MediaImage>?> getImagesbymediaID(
    int mediaID,
    String type,
  ) async {
    // https: //api.themoviedb.org/3/person/287/images?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/$type/$mediaID/images?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    List<MediaImage> imageList = [];

    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = type != 'person'
            ? jsonDecode(response.body)['backdrops']
            : jsonDecode(response.body)['profiles'];
        if (jsonBody is List) {
          for (var singleMap in jsonBody) {
            imageList.add(MediaImage.fromMap(singleMap));
          }
        }
        break;
      default:
        throw Exception(response.body);
    }

    return imageList;
  }

  Future<List<MediaImage>?> getTaggedImagesbyPersonID(
    int mediaID,
  ) async {
    // https: //api.themoviedb.org/3/person/287/images?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/person/$mediaID/tagged_images?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    List<MediaImage> imageList = [];

    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = jsonDecode(response.body)['results'];
        if (jsonBody is List) {
          for (var singleMap in jsonBody) {
            imageList.add(MediaImage.fromMap(singleMap));
          }
        }
        break;
      default:
        throw Exception(response.body);
    }

    return imageList;
  }

  Future<List<MediaVideo>?> getVideosbymediaID(
    int mediaID,
    String type,
  ) async {
    final String url = "$baseUrl/$type/$mediaID/videos?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    List<MediaVideo> videoList = [];

    switch (response.statusCode) {
      case HttpStatus.ok:
        var jsonBody = jsonDecode(response.body)['results'];
        if (jsonBody is List) {
          for (var singleMap in jsonBody) {
            videoList.add(MediaVideo.fromMap(singleMap));
          }
        }
        break;
      default:
        throw Exception(response.body);
    }
    return videoList;
  }

  Future<List<Review>> getReviewbyMediaID(
    int mediaID,
    int pageNumber,
    String type,
  ) async {
    //https://api.themoviedb.org/3/movie/75/reviews?api_key=07f5723af6c9503db9c8ce9493c975ce&page=1

    final String url =
        "$baseUrl/$type/$mediaID/reviews?api_key=$apiKey&page=$pageNumber";
    final response = await http.get(Uri.parse(url));

    List<Review> reviewList = [];
    var jsonBody = jsonDecode(response.body)['results'];

    switch (response.statusCode) {
      case HttpStatus.ok:
        if (jsonBody is List) {
          for (var singleMap in jsonBody) {
            reviewList.add(Review.fromMap(singleMap));
          }
        }
        break;
      default:
        throw Exception(response.body);
    }
    return reviewList;
  }

  Future<List<Genre>> getGenreList(String type) async {
    //https://api.themoviedb.org/3/genre/movie/list?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/genre/$type/list?api_key=$apiKey";
    debugPrint(url);
    final response = await http.get(Uri.parse(url));

//  var jsonBody = jsonDecode(response.body)['results'];
    List<Genre> genreList = [];
    var jsonBody = jsonDecode(response.body)['genres'];

    switch (response.statusCode) {
      case HttpStatus.ok:
        if (jsonBody is List) {
          for (var singleMap in jsonBody) {
            genreList.add(Genre.fromMap(singleMap));
          }
        }
        break;
      default:
        throw Exception(response.body);
    }
    return genreList;
  }

  //https://api.themoviedb.org/3/search/multi?api_key=07f5723af6c9503db9c8ce9493c975ce&query=

  Future<List<IBaseTrendingModel>?> searchQuery(
      {String? query, String? page = '1'}) async {
    if (query != null) {
      query.trim();
      query.replaceAll('', '%20');
      final String url =
          "$baseUrl/search/multi?api_key=$apiKey&query=$query&page=$page";
      final response = await http.get(Uri.parse(url));
      List<IBaseTrendingModel<dynamic>> resultList = [];
      var jsonBody = jsonDecode(response.body)['results'];
      switch (response.statusCode) {
        case HttpStatus.ok:
          if (jsonBody is List) {
            for (var singleMap in jsonBody) {
              switch (singleMap["media_type"]) {
                case "movie":
                  resultList.add(MovieTrending.fromMap(singleMap));
                  break;
                case "tv":
                  resultList.add(TvTrending.fromMap(singleMap));
                  break;
                case "person":
                  resultList.add(PeopleTrending.fromMap(singleMap));
                  break;
                default:
                  debugPrint('another type model pass here');
              }
            }
          }
          break;
        default:
          throw Exception(response.body);
      }
      return resultList;
    } else {
      return null;
    }
  }
}

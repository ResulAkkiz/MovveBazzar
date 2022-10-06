import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/media_base_model.dart';
import 'package:flutter_application_1/model/media_videos_model.dart';
import 'package:flutter_application_1/model/movie_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/people_cast_model.dart';
import 'package:flutter_application_1/model/people_model.dart';
import 'package:flutter_application_1/model/review_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:flutter_application_1/model/media_images_model.dart';
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

  Future<Movie> getMoviebyID<T>(int movieID) async {
    final String url = "$baseUrl/movie/$movieID?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return Movie.fromMap(jsonDecode(response.body));
      default:
        throw Exception(response.body);
    }
  }

  Future<List<PeopleCast>> getCastbyMovieId(int movieID) async {
    //https://api.themoviedb.org/3/movie/2/credits?api_key=07f5723af6c9503db9c8ce9493c975ce
    final String url = "$baseUrl/movie/$movieID/credits?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));
    var jsonBody = (jsonDecode(response.body))['cast'];

    switch (response.statusCode) {
      case HttpStatus.ok:
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

  Future<List<MediaImage>?> getImagesbymediaID(
    int mediaID,
    String type,
  ) async {
    final String url = "$baseUrl/$type/$mediaID/images?api_key=$apiKey";
    debugPrint(url);
    final response = await http.get(Uri.parse(url));
    List<MediaImage> imageList = [];
    var jsonBody = jsonDecode(response.body)['backdrops'];

    switch (response.statusCode) {
      case HttpStatus.ok:
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
    debugPrint(url);
    List<MediaVideo> videoList = [];
    var jsonBody = jsonDecode(response.body)['results'];

    switch (response.statusCode) {
      case HttpStatus.ok:
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
    debugPrint(url);
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
}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//  var jsonBody = jsonDecode(response.body)['results'];

//         switch (response.statusCode) {
//           case HttpStatus.ok:
//             if (jsonBody is List) {
//               for (var singleMap in jsonBody) {
//                 mediaList.add(MediaImage.fromMap(singleMap));
//               }
//             }
//             break;
//           default:
//             throw Exception(response.body);
//         }
//         break;
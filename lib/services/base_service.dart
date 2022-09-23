import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/movie_trending_model.dart';
import 'package:flutter_application_1/model/tv_trending_model.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final baseUrl = 'https://api.themoviedb.org/3';
  final apiKey = '07f5723af6c9503db9c8ce9493c975ce';

  Future<dynamic> getPopulars<T extends IBaseTrendingModel>(
      {required String type,
      required String pageNumber,
      required IBaseTrendingModel model}) async {
    final String _url =
        "$baseUrl/$type/popular?api_key=$apiKey&page=$pageNumber";
    debugPrint(_url);

    final response = await http.get(Uri.parse(_url));
    debugPrint(_url);

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
    required String pageNumber,
  }) async {
    final String url =
        "$baseUrl/trending/$type/$timeInterval?api_key=$apiKey&page=$pageNumber";
    final response = await http.get(Uri.parse(url));
    debugPrint(
        "$baseUrl/trending/$type/$timeInterval?api_key=$apiKey&page=$pageNumber");
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
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Future<List<IBaseTrendingModel>> getTrending<T extends IBaseTrendingModel>({
  //   required String type,
  //   required String timeInterval,
  //   required String pageNumber,
  // }) async {
  //   final String url =
  //       "$baseUrl/trending/$type/$timeInterval?api_key=$apiKey&page=$pageNumber";
  //   final response = await http.get(Uri.parse(url));

  //   switch (response.statusCode) {
  //     case HttpStatus.ok:
  //       List<IBaseTrendingModel> list = [];
  //       var jsonBody = (jsonDecode(response.body))['results'];
  //       debugPrint(jsonBody);
  //       if (jsonBody is List) {
  //         for (Map<String, dynamic> singleMap in jsonBody) {
  //           if (singleMap["media_type"] == "movie") {
  //             list.add(MovieTrending.fromMap(singleMap));
  //           } else if (singleMap["media_type"] == "tv") {
  //             list.add(TvTrending.fromMap(singleMap));
  //           } else {
  //             debugPrint('singleMap["media_type"] == "else"');
  //           }
  //         }
  //       }
  //       return list;
  //     default:
  //       throw Exception(response.body);
  //   }
  // }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter_application_1/model/base_search_model.dart';
import 'package:flutter_application_1/model/base_trending_model.dart';
import 'package:flutter_application_1/model/base_trending_show_model.dart';

abstract class IBaseSearchShowModel<T extends IBaseTrendingModel>
    implements IBaseSearchModel<T> {
  IBaseSearchShowModel();
}

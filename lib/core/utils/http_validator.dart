import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/utils/error_handler.dart';

mixin HttpValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException(message: Constants.defaultErrorMessage);
    }
  }
}

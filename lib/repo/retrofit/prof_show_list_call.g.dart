// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prof_show_list_call.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://bitsbosm.org/2022';
  }

  final Dio.Dio _dio;

  String? baseUrl;

  @override
  Future<ShowsData> getProfShowList(JWT) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-Wallet-Token': 'ec123dac-339b-41ba-bca4-d3cab464083d',
      r'Authorization': JWT
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ShowsData>(
            Dio.Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tickets-manager/shows/manager',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ShowsData.fromJson(_result.data!);
    return value;
  }

  Dio.RequestOptions _setStreamType<T>(Dio.RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == Dio.ResponseType.bytes ||
            requestOptions.responseType == Dio.ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = Dio.ResponseType.plain;
      } else {
        requestOptions.responseType = Dio.ResponseType.json;
      }
    }
    return requestOptions;
  }
}

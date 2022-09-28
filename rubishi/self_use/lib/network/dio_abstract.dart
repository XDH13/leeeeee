import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class BaseNetWork {
  static bool logEnabled = true;

  // 工厂模式
  factory BaseNetWork() => _getInstance();

  static BaseNetWork get instance => _getInstance();
  static BaseNetWork _instance;
  Dio dio;
  BaseOptions options;

  BaseNetWork._internal() {
    dio = Dio()
      ..options = BaseOptions(
          connectTimeout: 30000,
          sendTimeout: 1000 * 60 * 2,
          receiveTimeout: 1000 * 60 * 2,
          responseType: ResponseType.json)
    //网络状态拦截
      ..interceptors.add(NetCheckInterceptor())
      ..interceptors.add(ErrorInterceptor());
    if (logEnabled) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  static BaseNetWork _getInstance() {
    _instance ??= BaseNetWork._internal();
    return _instance;
  }

  static Future<Response<dynamic>> get(String path,
      {Map<String, dynamic> queryParameters}) {
    return BaseNetWork.instance.dio
        .get(path, queryParameters: queryParameters)
        .catchError((error, stack) {
      throw error;
    });
  }

  static Future<Response<dynamic>> post(String path,
      {Map<String, dynamic> queryParameters,
        FormData formData,
        ProgressCallback onSendProgress}) {
    return BaseNetWork.instance.dio
        .post(path,
        queryParameters: queryParameters,
        data: formData,
        onSendProgress: onSendProgress)
        .catchError((error, stack) {
      throw error;
    });
  }

  static Future<Response<dynamic>> put(String path,
      {Map<String, dynamic> queryParameters,
        FormData formData,
        ProgressCallback onSendProgress}) {
    return BaseNetWork.instance.dio
        .put(path,
        queryParameters: queryParameters,
        data: formData,
        onSendProgress: onSendProgress)
        .catchError((error, stack) {
      throw error;
    });
  }

  static Future<Response<dynamic>> patch(String path,
      {Map<String, dynamic> queryParameters,
        FormData formData,
        ProgressCallback onSendProgress}) {
    return BaseNetWork.instance.dio
        .patch(path,
        queryParameters: queryParameters,
        data: formData,
        onSendProgress: onSendProgress)
        .catchError((error, stack) {
      throw error;
    });
  }

  static Future<Response<dynamic>> delete(String path,
      {Map<String, dynamic> queryParameters, FormData formData}) {
    return BaseNetWork.instance.dio
        .delete(path, queryParameters: queryParameters, data: formData)
        .catchError((error, stack) {
      throw error;
    });
  }
}

class VoiceDioError extends DioError {
  @override
  final String error;

  VoiceDioError({requestOptions,  this.error})
      : super(requestOptions: requestOptions);
}
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError e, handler) async {
    if (e is WpyDioError) return handler.reject(e);
    if (e.type == DioErrorType.connectTimeout)
      e.error = "网络连接超时";
    else if (e.type == DioErrorType.sendTimeout)
      e.error = "发送请求超时";
    else if (e.type == DioErrorType.receiveTimeout)
      e.error = "响应超时";

    /// 除了以上列出的错误之外，其他的所有错误给一个统一的名称，防止让用户看到奇奇怪怪的错误代码
    else e.error = "发生未知错误，请联系开发人员解决";

    return handler.reject(e);
  }
}

class WpyDioError extends DioError {
  @override
  final String error;

  WpyDioError({ this.error, String path = 'unknown'})
      : super(requestOptions: RequestOptions(path: path));
}
class NetCheckInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(options, handler) async {
    if (NetStatusListener().hasNetwork)
      return handler.next(options);
    else
      return handler.reject(WpyDioError(error: '网络未连接'));
  }
}
class NetStatusListener {
  static final NetStatusListener _instance = NetStatusListener._();

  NetStatusListener._();

  factory NetStatusListener() => _instance;

  static Future<void> init() async {
    _instance._status = await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      _instance._status = result;
    });
  }

  ConnectivityResult _status = ConnectivityResult.none;

  bool get hasNetwork => _instance._status != ConnectivityResult.none;
}

import 'dart:io';
import 'dart:async';
import 'secverify_defines.dart';
import 'secverify_UIConfig.dart';
import 'package:flutter/services.dart';

class Secverify {
  static const MethodChannel _channel =
      const MethodChannel('com.mob.secverify.methodChannel');
  static const EventChannel _channelReceiver =
      const EventChannel('com.mob.secverify.verifyEventChannel');

  static Future<String?> get getVersion async {
    final String? version =
        await _channel.invokeMethod(SecVerifySDKMethods.getVersion.name);
    return version;
  }

  static Future<String?> get platformVersion async {
    return await _channel
        .invokeMethod(SecVerifySDKMethods.platformVersion.name);
  }

  static Future<dynamic> submitPrivacyGrantResult(
      bool status, Function(bool)? result) async {
    final Map<String, bool?> params = {'status': status};
    Future<dynamic> callBack = _channel.invokeMethod(
        SecVerifySDKMethods.uploadPrivacyStatus.name, params);
    callBack.then((dynamic response) {
      // if (response != null && response is bool) {
      //   result(response);
      // }
    });
    return callBack;
  }

  static Future<dynamic> get currentOperatorType async {
    return await _channel
        .invokeMethod(SecVerifySDKMethods.currentOperatorType.name);
  }

  static Future<dynamic> enableDebug({bool enable = false}) {
    final Map args = {'enable': enable};
    return _channel.invokeMethod(SecVerifySDKMethods.enableDebug.name, args);
  }

  static Future<dynamic> clearPhoneScripCache() {
    return _channel.invokeMethod(SecVerifySDKMethods.clearPhoneScripCache.name);
  }

  static Future<bool?> get isVerifySupport async {
    final bool? isSupport =
        await _channel.invokeMethod(SecVerifySDKMethods.secVerifyEnable.name);
    return isSupport;
  }

  static Future<dynamic> preVerify(
      {double timeout = 4.0, required SecVerifyResultListener result}) {
    final Map<String, dynamic> params = {'timeout': timeout};
    Future<dynamic> callBack =
        _channel.invokeMethod(SecVerifySDKMethods.preVerify.name, params);

    callBack.then((dynamic response) {
      if (response != null && response is Map) {
        result(response['ret'], response['err']);
      } else {
        result(null, null);
      }
    });

    return callBack;
  }

  static Future<dynamic> otherOAuthPageCallBack(
      SecVerifyResultListener result) {
    Future<dynamic> callBack =
        _channel.invokeMethod(SecVerifySDKMethods.otherOAuthPage.name);
    _channelReceiver.receiveBroadcastStream().listen((event) {
      if (event != null && event is Map) {
        result(event, null);
      } else {
        result(null, null);
      }
    });
    return callBack;
  }

  static Future<dynamic> setAndroidPortraitLayout(
      Map<String, Object> uiSettings) {
    final Map<String, Object> params = {'androidPortraitConfig': uiSettings};
    Future<dynamic> callback = _channel.invokeMethod(
        SecVerifySDKMethods.setAndroidPortraitLayout.name, params);
    return callback;
  }

  static Future<dynamic> setAndroidLandscapeLayout(
      Map<String, Object> landUiSettings) {
    final Map<String, Object> params = {
      'androidLandscapeConfig': landUiSettings
    };
    Future<dynamic> callback = _channel.invokeMethod(
        SecVerifySDKMethods.setAndroidLandscapeLayout.name, params);
    return callback;
  }

  static Future<dynamic>? verify(
      SecVerifyUIConfig config,
      SecVerifyResultListener openAuthListener,
      SecVerifyResultListener cancelAuthPageListener,
      SecVerifyResultListener oneKeyLoginListener,
      SecVerifyResultListener customEventListener,
      SecVerifyResultListener androidEventListener) {
    final Map<String, dynamic> params = config.toJson();

    Future<dynamic>? callBack;
    if (Platform.isIOS) {
      callBack = _channel.invokeMethod(SecVerifySDKMethods.verify.name, params);
      _channelReceiver.receiveBroadcastStream().listen((event) {
        if (event != null && event is Map) {
          verifyListenerType type =
              verifyListenerType.values[event['ListenerType']];
          switch (type) {
            case verifyListenerType.openAuthPage:
              if (openAuthListener != null) {
                openAuthListener(event['ret'], event['err']);
              }
              break;
            case verifyListenerType.cancelAuth:
              if (cancelAuthPageListener != null) {
                cancelAuthPageListener(event['ret'], event['err']);
              }
              break;
            case verifyListenerType.onLoginEvent:
              if (oneKeyLoginListener != null) {
                oneKeyLoginListener(event['ret'], event['err']);
              }
              break;
            case verifyListenerType.customBtnEvent:
              if (customEventListener != null) {
                customEventListener(event['ret'], event['err']);
              }
              break;
          }
        }
      }, onError: (event) {
        if (oneKeyLoginListener != null) {
          oneKeyLoginListener(null, null);
        }
      });
    } else if (Platform.isAndroid) {
      _channel.invokeMethod(
          SecVerifySDKMethods.setAndroidLandscapeLayout.name, params);
      _channel.invokeMethod(
          SecVerifySDKMethods.setAndroidPortraitLayout.name, params);
      callBack = _channel.invokeMethod(SecVerifySDKMethods.verify.name);
      _channelReceiver.receiveBroadcastStream().listen((event) {
        if (androidEventListener != null && event != null && event is Map) {
          if (event['ret'] != null) {
            androidEventListener(event, null);
          } else if (event['err'] != null) {
            androidEventListener(null, event);
          }
        }
      });
    }
    return callBack;
  }

  static Future<dynamic> mobileAuthToken(
      {double? timeout, required SecVerifyResultListener result}) {
    final Map<String, dynamic> args = {'timeout': timeout};
    Future<dynamic> callBack =
        _channel.invokeMethod(SecVerifySDKMethods.mobileAuthToken.name, args);

    if (Platform.isAndroid) {
      _channelReceiver.receiveBroadcastStream().listen((event) {
        print('flutter:dart:received mobileAuthToken');
        if (event != null && event is Map) {
          if (event['ret'] != null) {
            result(event['ret'], null);
          } else if (event['err'] != null) {
            result(null, event);
          }
        }
      });
    } else if (Platform.isIOS) {
      callBack.then((dynamic response) {
        if (response != null && response is Map) {
          result(response['ret'], response['err']);
        } else {
          result(null, null);
        }
      });
    }
    return callBack;
  }

  static Future<dynamic> mobileVerify(
      {required String phoneNum,
      required Map<String, dynamic> tokenInfo,
      double? timeout,
      required SecVerifyResultListener result}) {
    final Map<String, dynamic> args = {
      'phoneNum': phoneNum,
      'tokenInfo': tokenInfo,
      'timeout': timeout
    };
    Future<dynamic> callBack =
        _channel.invokeMethod(SecVerifySDKMethods.mobileVerify.name, args);

    callBack.then((dynamic response) {
      if (response != null && response is Map) {
        result(response['ret'], response['err']);
      } else {
        result(null, null);
      }
    });

    return callBack;
  }

  static Future<dynamic> manualDismissLoginVC({bool flag = false}) async {
    final Map<String, bool> args = {'flag': flag};
    return await _channel.invokeMethod(
        SecVerifySDKMethods.finishLoginVC.name, args);
  }

  static Future<dynamic> finishOAuthPage() {
    return _channel.invokeMethod(SecVerifySDKMethods.finishOAuthPage.name);
  }

  static Future<dynamic> autoFinishOAuthPage({bool flag = false}) {
    final Map<String, bool> args = {'autoFinish': flag};
    return _channel.invokeMethod(
        SecVerifySDKMethods.autoFinishOAuthPage.name, args);
  }

  static Future<dynamic> manualDismissLoading() {
    return _channel.invokeMethod(SecVerifySDKMethods.hideLoading.name);
  }

  static void addListener(SecVerifyResultListener result) {
    _channelReceiver
        .receiveBroadcastStream()
        .listen((event) {}, onError: (event) {});
  }
}

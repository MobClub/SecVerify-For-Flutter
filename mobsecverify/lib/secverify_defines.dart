enum verifyListenerType {
  openAuthPage,
  cancelAuth,
  onLoginEvent,
  customBtnEvent
}

typedef void SecVerifyResultListener(Map? rt, Map? err);

class SecVerifySDKMethod {
  final String name;
  final int id;

  SecVerifySDKMethod({required this.name, required this.id}) : super();
}

class SecVerifySDKMethods {
  static final SecVerifySDKMethod getVersion =
      SecVerifySDKMethod(name: 'getVersion', id: 0);
  static final SecVerifySDKMethod secVerifyEnable =
      SecVerifySDKMethod(name: 'secVerifyEnable', id: 1);
  static final SecVerifySDKMethod currentOperatorType =
      SecVerifySDKMethod(name: 'currentOperatorType', id: 2);
  static final SecVerifySDKMethod clearPhoneScripCache =
      SecVerifySDKMethod(name: 'clearPhoneScripCache', id: 3);
  static final SecVerifySDKMethod enableDebug =
      SecVerifySDKMethod(name: 'enableDebug', id: 4);
  static final SecVerifySDKMethod uploadPrivacyStatus =
      SecVerifySDKMethod(name: 'uploadPrivacyStatus', id: 5);
  static final SecVerifySDKMethod finishLoginVC =
      SecVerifySDKMethod(name: 'finishLoginVC', id: 6);
  static final SecVerifySDKMethod hideLoading =
      SecVerifySDKMethod(name: 'hideLoading', id: 7);
  static final SecVerifySDKMethod preVerify =
      SecVerifySDKMethod(name: 'preVerify', id: 8);
  static final SecVerifySDKMethod verify =
      SecVerifySDKMethod(name: 'verify', id: 9);
  static final SecVerifySDKMethod mobileAuthToken =
      SecVerifySDKMethod(name: 'mobileAuthToken', id: 10);
  static final SecVerifySDKMethod mobileVerify =
      SecVerifySDKMethod(name: 'mobileVerify', id: 11);
  static final SecVerifySDKMethod platformVersion =
      SecVerifySDKMethod(name: 'platformVersion', id: 12);
  static final SecVerifySDKMethod otherOAuthPage =
      SecVerifySDKMethod(name: 'OtherOAuthPageCallBack', id: 13);
  static final SecVerifySDKMethod setAndroidPortraitLayout =
      SecVerifySDKMethod(name: 'setAndroidPortraitLayout', id: 14);
  static final SecVerifySDKMethod setAndroidLandscapeLayout =
      SecVerifySDKMethod(name: 'setAndroidLandscapeLayout', id: 15);
  static final SecVerifySDKMethod finishOAuthPage =
      SecVerifySDKMethod(name: 'finishOAuthPage', id: 16);
  static final SecVerifySDKMethod autoFinishOAuthPage =
      SecVerifySDKMethod(name: 'autoFinishOAuthPage', id: 17);
  static final SecVerifySDKMethod toast =
      SecVerifySDKMethod(name: 'toast', id: 18);
}

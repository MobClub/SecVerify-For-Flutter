import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secverify/secverify.dart';
import 'package:secverify/secverify_UIConfig.dart';

class Home extends StatefulWidget {
  const Home({Key key}): super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // Properties
  bool _isSupport = false;
  Map<String, String> _mobileAuthToken;

  @override
  void initState() {
    super.initState();
    //隐私协议
    _submitPrivacyStatus(true);

    Secverify.preVerify(result: (Map ret, Map err) {
      if (err != null) {
        print('InitState PreVerify Failed: ${err.toString()}');
      }
    });
  }

  List<Widget> getWidgetList() {
    List<GridViewWidget> list = [
      GridViewWidget(GridViewWidgetMethodType.preVerify, '预登录请求'),
      GridViewWidget(GridViewWidgetMethodType.autoVerify, '登录验证_自动关闭'),
      GridViewWidget(GridViewWidgetMethodType.manualVerify, '登录验证_手动关闭'),
      GridViewWidget(GridViewWidgetMethodType.preMobileAuth, '本机认证_预请求'),
      GridViewWidget(GridViewWidgetMethodType.mobileAuthVerify, '本机认证'),
    ];
    return list.map((item) => getItemContainer(item)).toList();
  }

  Widget getItemContainer(GridViewWidget item) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: new Text(item.itemName ?? ''),
        onPressed: () {
          GridViewWidgetMethodType type = item.type;
          switch (type) {
            case GridViewWidgetMethodType.preVerify: {
                _preVerify(context);
            }
              break;
            case GridViewWidgetMethodType.autoVerify: {
              if (Platform.isIOS){
                SecVerifyUIConfig config = _configIOSUIConfig();
                _verify(config: config);
              } else if (Platform.isAndroid){
                SecVerifyUIConfig config = _configAndroidUIConfig();
                Secverify.autoFinishOAuthPage(flag: true);
                _verify(config: config);
              }
            }
              break;
            case GridViewWidgetMethodType.manualVerify: {
              SecVerifyUIConfig config = _configAndroidUIConfig();
              config.iOSConfig.manualDismiss = true;
              if (Platform.isIOS){
                _verify(config: config);
              } else if (Platform.isAndroid){
                Secverify.autoFinishOAuthPage(flag: false);
                _verify(config: config);
              }
            }
              break;
            case GridViewWidgetMethodType.preMobileAuth: {
              _mobileAuth(context);
            }
              break;
            case GridViewWidgetMethodType.mobileAuthVerify: {
              _showMobileVerifyAlert();
            }
              break;
            break;
          }
        },
        color: Colors.white,
      ),
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('SecVerify Demo'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 30.0,
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          children: getWidgetList(),
        ),
      ),
    );
  }

  /// Private Methods
  Future<void> _secVerifySupport() async {
    _isSupport = await Secverify.isVerifySupport;
  }

  void _submitPrivacyStatus(bool grantResult){
    Secverify.submitPrivacyGrantResult(grantResult);
  }

  void _preVerify(BuildContext context) {
    Secverify.preVerify(result: (Map ret, Map err) {
      if (ret != null && err == null) {
        // 显示预取号信息
        String retDetail = ret.toString();
        _showAlert(retDetail);
      } else if (err != null) {
        String errDetail = err.toString();
        _showAlert(errDetail);
      } else {
        _showAlert('预取号失败!');
      }
    });
  }

  ///android 授权页面监听
  void _otherOAuthPageCallBack(BuildContext context){
    Secverify.otherOAuthPageCallBack((ret,err){
      if (ret !=  null && ret.containsKey("ret")){
        //其他登陆
      }
    });
  }

  void _mobileAuth(BuildContext context) {
    Secverify.mobileAuthToken(timeout: 5.0, result: (Map ret, Map err) {
      if (ret != null && err == null) {
        // 显示本机认证Token信息
        String retDetail = ret.toString();
        if (retDetail.length != 0
            && retDetail.contains('token')
            && retDetail.contains('opToken')
            && retDetail.contains('operator')) {
          // 结果检验成功，进行本地设置
          _mobileAuthToken = Map.from(ret);
          _showAlert(_mobileAuthToken.toString());
        } else {
          _showAlert('请求本机认证Token失败 $retDetail');
        }

        print('Request Mobile Auth Token Info: $retDetail');
      } else if (err != null) {
        String errDetail = err.toString();
        _showAlert(errDetail);
      } else {
        _showAlert('请求本机认证Token失败');
      }
    });
  }

  void _verify({@required SecVerifyUIConfig config, BuildContext context}) {
    Secverify.verify(config, openAuthListener: (Map ret, Map err) {
      // 拉起授权页面结果回调
      if (err != null) {
        // 拉起授权页面失败
        _showAlert(err.toString());
      } else {
        print('Open Auth Page Result: ${ret.toString()}');
      }
    }, cancelAuthPageListener: (Map ret, Map err) {
      // 手动关闭或取消授权结果回调
      if (err != null) {
        _showAlert(err.toString());
      }
    }, oneKeyLoginListener: (Map ret, Map err) {
      if (config.iOSConfig.manualDismiss) {
        Secverify.manualDismissLoading();
        Secverify.manualDismissLoginVC(flag: true).then((value) {
          print('Manual Dismiss Loading VC Success');
        });
      }

      // 登录验证结果回调
      if (ret != null && err == null) {
        String resultStr = ret.toString();
        if (resultStr.length != 0
            && resultStr.contains('token')
            && resultStr.contains('opToken')
            && resultStr.contains('operator')) {
          // 结果检验成功，进行网络请求
          _doLoginWith(ret);
        } else {
          _showAlert('登录验证失败 $resultStr');
        }
      } else if (err != null) {
        _showAlert(err.toString());
      } else {
        _showAlert('登录验证失败');
      }
    }, customEventListener: (Map ret, Map err) {
      // 自定义控件点击事件结果回调
    },androidEventListener:(Map ret, Map err){
      if (ret != null && err == null) {
        String resultStr = ret['ret'].toString();
        if (resultStr.length != 0) {
          if (resultStr.contains('onOtherLogin')) {
            _showAlert('其他方式登陆');
          } else if (resultStr.contains('onUserCanceled')) {
            _showAlert('用户取消登陆');
          } else {
            if (resultStr.contains('token')
                && resultStr.contains('opToken')
                && resultStr.contains('operator')) {
              _doLoginWith(ret['ret']);
            }
          }
        }
      } else {
        if (err != null){
          _showAlert('取号失败 ${err['err'].toString()}');
        }
      }
    });
  }

  void _mobileVerify(String phoneNum, BuildContext context) {
    if (phoneNum == null || phoneNum.length == 0) {
      _showAlert('本机认证手机号码不能为空');
      return;
    }

    if (_mobileAuthToken == null) {
      _showAlert('进行本机认证操作前，请先请求Token');
      return;
    }
    Secverify.mobileVerify(phoneNum: phoneNum, tokenInfo: _mobileAuthToken, result: (Map ret, Map err) {
      // 本机认证结果处理
          if (ret != null && err == null) {
            String resultStr = ret.toString();
            if (resultStr.length != 0 &&
                resultStr.contains('isValid') &&
                resultStr.contains('valid')) {
              // 结果检验成功，进行网络请求
              _showAlert(resultStr);
            } else {
              _showAlert('本机认证失败 $resultStr');
            }
          } else if (err != null) {
            _showAlert(err.toString());
          } else {
            _showAlert('本机认证失败');
          }
    });
  }

  SecVerifyUIConfig _configUIConfig() {
    SecVerifyUIConfig config = SecVerifyUIConfig();
    return config;
  }
  SecVerifyUIConfig _configAndroidUIConfig() {
    SecVerifyUIConfig config = SecVerifyUIConfig();
    // _customizeAndroidUiExample(config);
    return config;
  }

  void _customizeAndroidUiExample(SecVerifyUIConfig config){
    //portrait
//标题栏
    config.androidPortraitConfig.navColorIdName="teal_200";//this color resource should put in the colors.xml in android project
    config.androidPortraitConfig.navTextIdName="one_key_login";//this string  should put in the strings.xml in android project
    config.androidPortraitConfig.navTextColorIdName="white";
    config.androidPortraitConfig.navHidden = false;
    config.androidPortraitConfig.navTransparent = true;//默认是true
    config.androidPortraitConfig.navCloseImgHidden = false;
    config.androidPortraitConfig.navTextSize = 15;
    config.androidPortraitConfig.navCloseImgPath='close.png';//this image should put in the assets package in android project
    // config.androidPortraitConfig.navCloseImgWidth=15;
    // config.androidPortraitConfig.navCloseImgHeight=15;//标题栏的高度是自适应这个图片的高度的
    // config.androidPortraitConfig.navCloseImgOffsetX=10;
    // config.androidPortraitConfig.navCloseImgOffsetRightX=10;
    // config.androidPortraitConfig.navCloseImgOffsetY=10;
    config.androidPortraitConfig.navTextBold=false;
    // config.androidPortraitConfig.navCloseImgScaleType=ImageScaleType.CENTER_CROP;

//号码上方logo
    config.androidPortraitConfig.logoImgPath = 'logo.png';
    config.androidPortraitConfig.logoWidth = 80;
    config.androidPortraitConfig.logoHeight = 80;
    // config.androidPortraitConfig.logoOffsetX = 20;
    // config.androidPortraitConfig.logoOffsetY = 60;
    // config.androidPortraitConfig.logoOffsetBottomY = 20;
    // config.androidPortraitConfig.logoOffsetRightX = 20;
    // config.androidPortraitConfig.logoAlignParentRight = true;
    // config.androidPortraitConfig.logoHidden = false;
//手机号码
    config.androidPortraitConfig.numberColorIdName = 'teal_200';
    config.androidPortraitConfig.numberSize = 20;
    // config.androidPortraitConfig.numberOffsetX = 20;
    // config.androidPortraitConfig.numberOffsetY = 20;
    // config.androidPortraitConfig.numberOffsetBottomY = 20;
    // config.androidPortraitConfig.numberOffsetRightX = 20;//seems like margin right
    // config.androidPortraitConfig.numberAlignParentRight = true;
    // config.androidPortraitConfig.numberOffsetX = 20;//seems like margin left
    // config.androidPortraitConfig.numberHidden = true;
    config.androidPortraitConfig.numberBold = false;
//切换账号
    config.androidPortraitConfig.switchAccColorIdName='teal_700';//textColor
    config.androidPortraitConfig.switchAccTextSize=13;
    config.androidPortraitConfig.switchAccHidden=false;
    // config.androidPortraitConfig.switchAccOffsetX=20;//控件位于屏幕最左侧 + marginleft值
    // config.androidPortraitConfig.switchAccOffsetY=20;//控件位于屏幕最上侧 + marginTop值
    // config.androidPortraitConfig.switchAccOffsetBottomY=20;//控件位于屏幕最下侧 + marginBottom值
    // config.androidPortraitConfig.switchAccOffsetRightX=20;//控件位于屏幕最右侧 + marginRight值
    // config.androidPortraitConfig.switchAccAlignParentRight=true;//控件是否位于屏幕最右侧
    config.androidPortraitConfig.switchAccText='切换手机账号';
    // config.androidPortraitConfig.switchAccTextBold=true;//Bold

//登录按钮
    config.androidPortraitConfig.loginBtnImgIdName="btn_bg";//this drawable resource should put in the drawable package in android project
//     config.androidPortraitConfig.loginImgPressedName="#FF6200EE";//loginImgPressedName和loginImgPressedName同时设置才会生效
//     config.androidPortraitConfig.loginImgPressedName="#FF000000";//loginImgPressedName和loginImgPressedName同时设置才会生效
    // config.androidPortraitConfig.loginBtnTextIdName="one_key_login";//receive an id,not a String
    config.androidPortraitConfig.loginBtnTextColorIdName="teal_200";//receive a string,not an id
    config.androidPortraitConfig.loginBtnTextSize=15;
    config.androidPortraitConfig.loginBtnWidth=300;
    config.androidPortraitConfig.loginBtnHeight=40;
    // config.androidPortraitConfig.loginBtnOffsetX=4;
    // config.androidPortraitConfig.loginBtnOffsetY=4;
    // config.androidPortraitConfig.loginBtnOffsetBottomY=4;
    // config.androidPortraitConfig.loginBtnOffsetRightX=40;
    // config.androidPortraitConfig.loginBtnAlignParentRight=true;
    // config.androidPortraitConfig.loginBtnHidden=true;
    // config.androidPortraitConfig.loginBtnTextBold=true;
    config.androidPortraitConfig.loginBtnTextStringName='一键登录';

//复选框
    // config.androidPortraitConfig.checkboxDefaultState=true;
    // config.androidPortraitConfig.checkboxHidden=true;
    // config.androidPortraitConfig.checkboxOffsetX=20;
    // config.androidPortraitConfig.checkboxOffsetRightX=20;//距离右边隐私协议文字的距离
    // config.androidPortraitConfig.checkboxOffsetY=1;//默认同文字居中，该值为距离中线距离
    // config.androidPortraitConfig.checkboxOffsetBottomY=30;
    // config.androidPortraitConfig.checkboxScaleX=1;//复选框横向拉伸距离
    // config.androidPortraitConfig.checkboxScaleY=1;//复选框纵向拉伸距离
    // config.androidPortraitConfig.checkedImgName='close.png';//两个同事设置有效
    // config.androidPortraitConfig.uncheckedImgName='logo.png';//两个同事设置有效
    // config.androidPortraitConfig.checkboxWidth=100;//只有在包含checkedImgName设置的宽度和高度才会有效
    // config.androidPortraitConfig.checkboxHeight=50;//

//一键登录页面 隐私协议自定义
    // config.androidPortraitConfig.agreementColor='purple_200';//高亮显示字体颜色
    // config.androidPortraitConfig.agreementOffsetX=200;//包括checkbox一起距离左侧距离
    // config.androidPortraitConfig.agreementOffsetRightX=2;//包括checkbox一起距离右侧距离
    // config.androidPortraitConfig.agreementOffsetY=2;//包括checkbox一起距离屏幕最上侧距离
    // config.androidPortraitConfig.agreementOffsetBottomY=2;//包括checkbox一起距离屏幕最下侧距离
    // config.androidPortraitConfig.agreementGravityLeft=true;//隐私协议是否左对齐，默认居中
    // config.androidPortraitConfig.agreementBaseTextColor='black';
    // config.androidPortraitConfig.agreementTextSize=12;
    // config.androidPortraitConfig.agreementTextStartString='登录即同意';
    // config.androidPortraitConfig.agreementTextEndString='并使用本机号码登录';
    // config.androidPortraitConfig.agreementTextStartIdName='agreement_Start';//通过传入安卓原生项目中的资源id
    // config.androidPortraitConfig.agreementTextEndIdName='agreement_end';//通过传入安卓原生项目中的资源id
    // config.androidPortraitConfig.agreementAlignParentRight=true;
    // config.androidPortraitConfig.agreementHidden=false;
    // config.androidPortraitConfig.agreementCtccTextString="中国电信";
    // config.androidPortraitConfig.agreementCtccTextId="test_id";
    // config.androidPortraitConfig.agreementTextAndString1="test_id";//设置多个协议必须设置相应的url才会有效果
    // config.androidPortraitConfig.agreementTextAndString2="test_id";
    // config.androidPortraitConfig.agreementTextBold=false;
    // config.androidPortraitConfig.agreementTextWithUnderLine=true;//高亮部分下划线
    // config.androidPortraitConfig.cusAgreementNameId1='app_name';//cusAgreementNameId1与cusAgreementUrl1必须同时出现才会有效果
    // config.androidPortraitConfig.cusAgreementUrl1='https://www.baidu.com/';
    // config.androidPortraitConfig.cusAgreementNameId2='app_name';
    // config.androidPortraitConfig.cusAgreementColor1='purple_200';
    // config.androidPortraitConfig.cusAgreementNameText2='app_name';
    // config.androidPortraitConfig.agreementUncheckHintText='uncheck_tip';

//服务协议页面内容自定义
    config.androidPortraitConfig.agreementPageTitleString='服务与隐私协议';//有缓存可能需要重装应用
    // config.androidPortraitConfig.cusAgreementPageOneTitleString='测试标题一';
    // config.androidPortraitConfig.cusAgreementPageTwoTitleString='测试标题二';//第二个隐私协议页面标题
    // config.androidPortraitConfig.cusAgreementPageThreeTitleString='测试标题三';//第三个隐私协议页面标题
    // config.androidPortraitConfig.cusAgreementPageOneTitleNameId='app_name';
    // config.androidPortraitConfig.cusAgreementPageTwoTitleNameId='app_name';
    // config.androidPortraitConfig.cusAgreementPageThreeTitleNameId='app_name';
    // config.androidPortraitConfig.agreementPageCloseImg='checked.png';//设置协议web页面的返回键
    // config.androidPortraitConfig.agreementPageCloseImgHidden=true;//设置一键登录的标题栏的
    // config.androidPortraitConfig.agreementPageCloseImgWidth=15;//返回图标宽度
    // config.androidPortraitConfig.agreementPageCloseImgHeight=15;//返回图标高度
    config.androidPortraitConfig.agreementPageTitleTextSize=15;//标题字体大小
    config.androidPortraitConfig.agreementPageTitleTextColor='#FFBB86FC';//rgb
    // config.androidPortraitConfig.agreementPageTitleTextBold=true;
    // config.androidPortraitConfig.agreementPageTitleHidden=true;

//slogan(中国电信提供认证服务)
    //config.androidPortraitConfig.sloganOffsetX=20;//左偏移
    //config.androidPortraitConfig.sloganOffsetY=20;
    //config.androidPortraitConfig.sloganOffsetBottomY=20;
    config.androidPortraitConfig.sloganTextSize=10;
    config.androidPortraitConfig.sloganTextColor='purple_200';
    // config.androidPortraitConfig.sloganOffsetRightX=20;//右偏移
    config.androidPortraitConfig.sloganAlignParentRight=false;//右
    config.androidPortraitConfig.sloganHidden=false;
    config.androidPortraitConfig.sloganTextBold=false;//加粗

//弹框模式
    config.androidPortraitConfig.dialogTheme=false;//一键登录页面是否采用弹框模式
    config.androidPortraitConfig.dialogAlignBottom=false;
    // config.androidPortraitConfig.dialogOffsetX=200;//对dialogAlignBottom=falses时生效
    // config.androidPortraitConfig.dialogOffsetY=200;//对dialogAlignBottom=falses时生效
    // config.androidPortraitConfig.dialogWidth=300;//对dialogAlignBottom=falses时生效
    // config.androidPortraitConfig.dialogHeight=300;//对dialogAlignBottom=falses时生效
    config.androidPortraitConfig.dialogBackground='bg.png';//弹框弹出后的背景板
    config.androidPortraitConfig.dialogBackgroundClickClose=false;//弹框弹出后的背景板


//大背景
    config.androidPortraitConfig.backgroundImgPath='bg_my.png';
    // config.androidPortraitConfig.fullScreen=true;

//自定义控件 新增一个textview
    var list0 = new List<AndroidCustomView>();
    AndroidCustomView customView = new AndroidCustomView();
    customView.viewClass='TextView';
    customView.viewText='自定义控件';
    customView.viewTextFont=15;
    customView.viewTextBold=false;
    customView.viewAlignParentRight=false;
    customView.viewHorizontalCenter=true;
    customView.viewHorizontalCenterVertical=false;
    // customView.viewOffsetX=20;
    // customView.viewOffsetY=20;
    // customView.viewOffsetRightX=20;
    // customView.viewOffsetBottomY=20;
    customView.viewWidth=50;
    customView.viewHeight=20;
    list0.add(customView);

    Map<String,List<AndroidCustomView>> customViewMap = new Map();
    customViewMap['customView'] = list0;

  // config.androidPortraitConfig.customView= customViewMap;//新增自定义控件
  }

  SecVerifyUIConfig _configIOSUIConfig() {
    SecVerifyUIConfig config = SecVerifyUIConfig();
    config.iOSConfig.manualDismiss = false;

    config.iOSConfig.navBarHidden = true;
    config.iOSConfig.prefersStatusBarHidden = false;

    config.iOSConfig.shouldAutorotate = true;
    config.iOSConfig.supportedInterfaceOrientations = iOSInterfaceOrientationMask.all;
    config.iOSConfig.preferredInterfaceOrientationForPresentation = iOSInterfaceOrientation.portrait;

    return config;
  }

  void _showAlert([String text, bool isError = false]) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: new Text('提示'),
          content: new Text(text),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('OK')),
          ],
        )
    );
  }

  final _textEditVC = TextEditingController();
  void _showMobileVerifyAlert() {
    if (Platform.isAndroid){
      _showAlert('Android SecVerify not support mobileAuth now');
    } else {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: new Text('请输入手机号码:'),
          content: new TextField(
            controller: _textEditVC,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            autofocus: true,
            maxLength: 11,
            maxLengthEnforced: true,
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  final _phoneNum = _textEditVC.text;
                  if (_phoneNum.length == 11) {
                    _mobileVerify(_phoneNum, context);
                  } else {
                    _showAlert('输入的手机号非法,请确认后输入!');
                  }
                },
                child: new Text('OK')
            ),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('Cancel')
            ),
          ],
        )
    );
    }
  }

  void _doLoginWith(Map params) async {
    //因为在调用处已经添加了参数合法性判断，此处无需再进行合法性判断
    var header = Map<String, String>();
    header['Content-Type'] = 'application/json';
    final client = http.Client();
    final response = await client.post(Uri.http("demo.verify.mob.com", "/demo/sdkLogin"), headers: header, body: json.encode(params));
    print('Login Result: ${response.body.toString()}');
    Secverify.manualDismissLoading();
    _showAlert(response.body.toString());
  }
}

enum GridViewWidgetMethodType {
  preVerify,
  autoVerify,
  manualVerify,
  preMobileAuth,
  mobileAuthVerify,
  setCustomUi
}

class GridViewWidget {
  // Properties
  String itemName;
  GridViewWidgetMethodType type;

  GridViewWidget([GridViewWidgetMethodType type, String name]) {
    this.type = type;
    this.itemName = name;
  }
}
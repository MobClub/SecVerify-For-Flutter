// import 'package:json_annotation/json_annotation.dart';
// import 'package:collection/collection.dart' show IterableExtension;

part 'secverify_UIConfig.g.dart';

enum ImageScaleType {
  MATRIX,
  FIT_XY,
  FIT_START,
  FIT_CENTER,
  FIT_END,
  CENTER,
  CENTER_CROP,
  CENTER_INSIDE
}

enum iOSCustomWidgetNavPosition { navLeft, navRight }

enum iOSCustomWidgetType { label, button, imageView }

enum iOSUserInterfaceStyle {
  // @JsonValue(0)
  unspecified,
  // @JsonValue(1)
  light,
  // @JsonValue(2)
  dark
}
enum iOSUIViewContentMode {
  // @JsonValue(0)
  scaleToFill,
  // @JsonValue(1)
  scaleAspectFit,
  // @JsonValue(2)
  scaleAspectFill
}
enum iOSModalPresentationStyle {
  // @JsonValue(0)
  fullScreen,
  // @JsonValue(1)
  pageSheet,
  // @JsonValue(2)
  forSheet,
  // @JsonValue(3)
  currentContext,
  // @JsonValue(4)
  custom,
  // @JsonValue(5)
  overFullScreen,
  // @JsonValue(6)
  overCurrentContext,
  // @JsonValue(7)
  popOver,
  // @JsonValue(8)
  blurOverFullScreen,
  // @JsonValue(-1)
  none,
  // @JsonValue(-2)
  automatic
}

enum iOSModalTransitionStyle {
  // @JsonValue(0)
  coverVertical,
  // @JsonValue(1)
  flipHorizontal,
  // @JsonValue(2)
  crossDissolve,
  // @JsonValue(3)
  partialCurl
}

enum iOSInterfaceOrientation {
  // @JsonValue(1)
  portrait,
  // @JsonValue(2)
  portraitUpsideDown,
  // @JsonValue(4)
  landscapeLeft,
  // @JsonValue(3)
  landscapeRight,
  // @JsonValue(0)
  unknown
}

enum iOSInterfaceOrientationMask {
  // @JsonValue(2)
  portrait,
  // @JsonValue(16)
  landscapeLeft,
  // @JsonValue(8)
  landscapeRight,
  // @JsonValue(4)
  portraitUpsideDown,
  // @JsonValue(24)
  landscape,
  // @JsonValue(30)
  all,
  // @JsonValue(26)
  allButUpsideDown
}

enum iOSTextAlignment {
  // @JsonValue(1)
  center,
  // @JsonValue(0)
  left,
  // @JsonValue(2)
  right,
  // @JsonValue(3)
  justified,
  // @JsonValue(4)
  natural
}

enum iOSStatusBarStyle {
  // @JsonValue(0)
  styleDefault,
  // @JsonValue(1)
  styleLightContent,
  // @JsonValue(3)
  styleDarkContent
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfig {
  SecVerifyUIConfigIOS? _iOSConfig;
  SecVerifyUIConfigAndroid? _androidPortraitConfig;
  SecVerifyUIConfigAndroid? _androidLandscapeConfig;

  SecVerifyUIConfig() {}
  set iOSConfig(SecVerifyUIConfigIOS? config) => _iOSConfig;

  SecVerifyUIConfigIOS? get iOSConfig {
    if (_iOSConfig == null) {
      _iOSConfig = new SecVerifyUIConfigIOS();
    }

    return _iOSConfig;
  }

  set androidPortraitConfig(SecVerifyUIConfigAndroid? config) =>
      _androidPortraitConfig;

  SecVerifyUIConfigAndroid? get androidPortraitConfig {
    if (_androidPortraitConfig == null) {
      _androidPortraitConfig = new SecVerifyUIConfigAndroid();
    }
    return _androidPortraitConfig;
  }

  set androidLandscapeConfig(SecVerifyUIConfigAndroid? config) =>
      _androidLandscapeConfig;

  SecVerifyUIConfigAndroid? get androidLandscapeConfig {
    if (_androidLandscapeConfig == null) {
      _androidLandscapeConfig = new SecVerifyUIConfigAndroid();
    }
    return _androidLandscapeConfig;
  }

  factory SecVerifyUIConfig.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOS {
  bool? navBarHidden;
  bool manualDismiss = true;
  bool? prefersStatusBarHidden;

  /*
 *需先设置Info.plist: View controller-based status bar appearance = YES 方可生效
 *
 *UIStatusBarStyleDefault：状态栏显示 黑
 *UIStatusBarStyleLightContent：状态栏显示 白
 *UIStatusBarStyleDarkContent：状态栏显示 黑 API_AVAILABLE(ios(13.0)) = 3
 **eg. @(UIStatusBarStyleLightContent)
 */
  iOSStatusBarStyle? preferredStatusBarStyle;

  bool? shouldAutorotate;
  iOSInterfaceOrientationMask? supportedInterfaceOrientations;
  iOSInterfaceOrientation? preferredInterfaceOrientationForPresentation;
  bool? presentingWithAnimate;
  iOSModalTransitionStyle? modalTransitionStyle;
  iOSModalPresentationStyle? modalPresentationStyle;
  bool? showPrivacyWebVCByPresent;
  iOSStatusBarStyle? privacyWebVCPreferredStatusBarStyle;
  iOSModalPresentationStyle? privacyWebVCModalPresentationStyle;
  iOSUserInterfaceStyle? overrideUserInterfaceStyle;
  String? backBtnImageName;
  String? loginBtnText;
  String? loginBtnBgColor;
  String? loginBtnTextColor;
  double? loginBtnBorderWidth;
  double? loginBtnCornerRadius;
  String? loginBtnBorderColor;
  List<String>? loginBtnBgImgNames;
  bool? logoHidden;
  String? logoImageName;
  double? logoCornerRadius;
  // bool? phoneHidden;
  String? numberColor;
  String? numberBgColor;
  iOSTextAlignment? numberTextAlignment;
  double? phoneCorner;
  double? phoneBorderWidth;
  String? phoneBorderColor;
  bool? checkHidden;
  bool? checkDefaultState;
  String? checkedImgName;
  String? uncheckedImgName;
  double? privacyLineSpacing;
  iOSTextAlignment? privacyTextAlignment;
  List<SecVerifyUIConfigIOSPrivacyText?>? privacySettings;
  bool? sloganHidden;
  // String? sloganText;
  String? sloganBgColor;
  String? sloganTextColor;
  iOSTextAlignment? sloganTextAlignment;
  double? sloganCorner;
  double? sloganBorderWidth;
  String? sloganBorderColor;
  List<SecVerifyUIConfigIOSCustomView?>? widgets;
  SecVerifyUIConfigIOSCustomLayouts? portraitLayouts;
  SecVerifyUIConfigIOSCustomLayouts? landscapeLayouts;

  SecVerifyUIConfigIOS() {}

  factory SecVerifyUIConfigIOS.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSPrivacyText {
  String? text;
  double? textFont;
  String? textFontName;
  String? textColor;
  String? webTitleText;//隐私协议web页标题显示文字,默认取text
  String? textLinkString;
  bool? isOperatorPlaceHolder;
  Map<String, dynamic>? textAttribute;

  SecVerifyUIConfigIOSPrivacyText() {}

  factory SecVerifyUIConfigIOSPrivacyText.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSPrivacyTextFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SecVerifyUIConfigIOSPrivacyTextToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomView {
  int? widgetID;

  double? cornerRadius;
  String? backgroundColor;
  double? borderWidth;
  String? borderColor;

  SecVerifyUIConfigIOSLayout? portraitLayout;
  SecVerifyUIConfigIOSLayout? landscapeLayout;

  SecVerifyUIConfigIOSCustomView(
      {required this.widgetID});

  factory SecVerifyUIConfigIOSCustomView.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomViewFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSCustomViewToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomNavButton extends SecVerifyUIConfigIOSCustomButton {

  iOSCustomWidgetNavPosition? navPosition;

  SecVerifyUIConfigIOSCustomNavButton(int? widgetID) : super(widgetID);
  factory SecVerifyUIConfigIOSCustomNavButton.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomNavButtonFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSCustomNavButtonToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomButton extends SecVerifyUIConfigIOSCustomView {
  String? title;          //标题(normal)
  String? titleColor;     //标题文字颜色，HEX，eg. "c194ff"(normal)
  double? titleFontSize;  //标题文字大小(normal)
  var isBodyFont = false; //标题文字是否粗体(normal)
  String? normalImage;    //按钮图片(normal)
  String? normalBackgroundImage;//按钮背景图片(normal)

  String? highlightedImage; //按钮图片(highlighted)
  String? disabledImage;    //按钮图片(disabled)
  String? selectedImage;    //按钮图片(selected)

  String? highlightedBackgroundImage;   //按钮背景图片(highlighted)
  String? disabledBackgroundImage;      //按钮背景图片(disabled)
  String? selectedBackgroundImage;      //按钮背景图片(selected)

  iOSCustomWidgetType? widgetType = iOSCustomWidgetType.button;
  SecVerifyUIConfigIOSCustomButton(int? widgetID) : super(widgetID: widgetID);
  factory SecVerifyUIConfigIOSCustomButton.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomButtonFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSCustomButtonToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomImageView extends SecVerifyUIConfigIOSCustomView {
  String? image;
  iOSUIViewContentMode? contentMode;

  iOSCustomWidgetType? widgetType = iOSCustomWidgetType.imageView;
  SecVerifyUIConfigIOSCustomImageView(int? widgetID) : super(widgetID: widgetID);
  factory SecVerifyUIConfigIOSCustomImageView.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomImageViewFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSCustomImageViewToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomLabel extends SecVerifyUIConfigIOSCustomView {
  String? text;
  String? textColor;
  double? fontSize;
  var isBodyFont = false;
  iOSTextAlignment? textAlignment;

  iOSCustomWidgetType? widgetType = iOSCustomWidgetType.label;
  SecVerifyUIConfigIOSCustomLabel(int? widgetID) : super(widgetID: widgetID);
  factory SecVerifyUIConfigIOSCustomLabel.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomLabelFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSCustomLabelToJson(this);
}
// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSCustomLayouts {
  SecVerifyUIConfigIOSLayout? loginBtnLayout;
  SecVerifyUIConfigIOSLayout? phoneLabelLayout;
  SecVerifyUIConfigIOSLayout? sloganLabelLayout;
  SecVerifyUIConfigIOSLayout? logoImageViewLayout;
  SecVerifyUIConfigIOSLayout? privacyTextViewLayout;
  SecVerifyUIConfigIOSPrivacyCheckBoxLayout? checkBoxLayout;

  SecVerifyUIConfigIOSCustomLayouts() {}

  factory SecVerifyUIConfigIOSCustomLayouts.fromJson(
          Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSCustomLayoutsFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SecVerifyUIConfigIOSCustomLayoutsToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSLayout {
  double? layoutTop;
  double? layoutLeading;
  double? layoutBottom;
  double? layoutTrailing;
  double? layoutCenterX;
  double? layoutCenterY;
  double? layoutWidth;
  double? layoutHeight;

  SecVerifyUIConfigIOSLayout() {}

  factory SecVerifyUIConfigIOSLayout.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSLayoutFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigIOSLayoutToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigIOSPrivacyCheckBoxLayout {
/*注：因checkBox通常放置于隐私协议控件旁边，所以CheckBox布局时的相对控件默认为隐私协议控件。
  如需设置为相对于父视图(授权页)的布局，请设置layoutToSuperView=true*/
  double? layoutTop;
  double? layoutLeading;
  double? layoutBottom;
  double? layoutTrailing;
  double? layoutCenterX;
  double? layoutCenterY;
  double? layoutWidth;
  double? layoutHeight;

  /*上述8个约束是否相对于父视图(授权页)，默认相对于隐私协议控件*/
  bool? layoutToSuperView;

  /*额外常用的约束(相对于隐私协议控件)*/
  double? layoutRightSpaceToPrivacyLeft;//checkBox右边到隐私控件左边的距离
  double? layoutLeftSpaceToPrivacyRight;//checkBox左边边到隐私控件右边的距离

  SecVerifyUIConfigIOSPrivacyCheckBoxLayout() {}

  factory SecVerifyUIConfigIOSPrivacyCheckBoxLayout.fromJson(
          Map<String, dynamic> json) =>
      _$SecVerifyUIConfigIOSPrivacyCheckBoxLayoutFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SecVerifyUIConfigIOSPrivacyCheckBoxLayoutToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class SecVerifyUIConfigAndroid {
  String? loginBtnImgIdName;
  String? loginImgPressedName;
  String? loginImgNormalName;
  String? loginBtnTextIdName;
  String? loginBtnTextColorIdName;
  int? loginBtnTextSize;
  int? loginBtnWidth;
  int? loginBtnHeight;
  int? loginBtnOffsetX;
  int? loginBtnOffsetY;
  int? loginBtnOffsetBottomY;
  int? loginBtnOffsetRightX;
  bool? loginBtnAlignParentRight;
  bool? loginBtnHidden;
  String? loginBtnTextStringName;
  bool? loginBtnTextBold;
  String? backgroundImgPath;
  bool? backgroundClickClose;
  bool? fullScreen;
  bool? virtualButtonTransparent;
  bool? immersiveTheme;
  bool? immersiveStatusTextColorBlack;
  String? navColorIdName;
  String? navTextIdName;
  String? navTextColorIdName;
  bool? navHidden;
  bool? navTransparent;
  bool? navCloseImgHidden;
  int? navTextSize;
  String? navCloseImgPath;
  int? navCloseImgWidth;
  int? navCloseImgHeight;
  int? navCloseImgOffsetX;
  int? navCloseImgOffsetRightX;
  int? navCloseImgOffsetY;
  bool? navTextBold;
  ImageScaleType? navCloseImgScaleType;
  String? numberColorIdName;
  int? numberSize;
  int? numberOffsetX;
  int? numberOffsetY;
  int? numberOffsetBottomY;
  int? numberOffsetRightX;
  bool? numberAlignParentRight;
  bool? numberHidden;
  bool? numberBold;
  String? switchAccColorIdName;
  int? switchAccTextSize;
  bool? switchAccHidden;
  int? switchAccOffsetX;
  int? switchAccOffsetY;
  int? switchAccOffsetBottomY;
  int? switchAccOffsetRightX;
  bool? switchAccAlignParentRight;
  String? switchAccText;
  bool? switchAccTextBold;
  bool? checkboxDefaultState;
  bool? checkboxHidden;
  int? checkboxOffsetX;
  int? checkboxOffsetRightX;
  int? checkboxOffsetY;
  int? checkboxOffsetBottomY;
  double? checkboxScaleX;
  double? checkboxScaleY;
  String? checkedImgName;
  String? uncheckedImgName;
  int? checkboxWidth;
  int? checkboxHeight;
  String? agreementColor;
  int? agreementOffsetX;
  int? agreementOffsetRightX;
  int? agreementOffsetY;
  int? agreementOffsetBottomY;
  bool? agreementGravityLeft;
  String? agreementBaseTextColor;
  int? agreementTextSize;
  String? agreementTextStartIdName;
  String? agreementTextEndIdName;
  bool? agreementAlignParentRight;
  bool? agreementHidden;
  String? agreementCmccTextString;
  String? agreementCuccTextString;
  String? agreementCtccTextString;
  String? agreementCtccTextId;
  String? agreementTextStartString;
  String? agreementTextAndString1;
  String? agreementTextAndString2;
  String? agreementTextAndString3;
  String? agreementTextEndString;
  bool? agreementTextBold;
  bool? agreementTextWithUnderLine;
  String? cusAgreementNameId1;
  String? cusAgreementUrl1;
  String? cusAgreementColor1;
  String? cusAgreementNameId2;
  String? cusAgreementUrl2;
  String? cusAgreementColor2;
  String? cusAgreementNameId3;
  String? cusAgreementUrl3;
  String? cusAgreementColor3;
  String? cusAgreementNameText1;
  String? cusAgreementNameText2;
  String? cusAgreementNameText3;
  int? agreementUncheckHintType;
  String? agreementUncheckHintText;
  String? agreementPageTitleString;
  String? cusAgreementPageOneTitleString;
  String? cusAgreementPageTwoTitleString;
  String? cusAgreementPageThreeTitleString;
  String? agreementPageTitleStringId;
  String? cusAgreementPageOneTitleNameId;
  String? cusAgreementPageTwoTitleNameId;
  String? cusAgreementPageThreeTitleNameId;
  String? agreementPageCloseImg;
  bool? agreementPageCloseImgHidden;
  int? agreementPageCloseImgWidth;
  int? agreementPageCloseImgHeight;
  int? agreementPageTitleTextSize;
  String? agreementPageTitleTextColor;
  bool? agreementPageTitleTextBold;
  bool? agreementPageTitleHidden;
  int? sloganOffsetX;
  int? sloganOffsetY;
  int? sloganOffsetBottomY;
  int? sloganTextSize;
  String? sloganTextColor;
  int? sloganOffsetRightX;
  bool? sloganAlignParentRight;
  bool? sloganHidden;
  bool? sloganTextBold;
  bool? dialogTheme;
  bool? dialogAlignBottom;
  int? dialogOffsetX;
  int? dialogOffsetY;
  int? dialogWidth;
  int? dialogHeight;
  String? dialogBackground;
  bool? dialogBackgroundClickClose;
  Map<String, List<AndroidCustomView?>?>? customView;
  String? logoImgPath;
  int? logoWidth;
  int? logoHeight;
  int? logoOffsetX;
  int? logoOffsetY;
  int? logoOffsetBottomY;
  int? logoOffsetRightX;
  bool? logoAlignParentRight;
  bool? logoHidden;

  SecVerifyUIConfigAndroid() {}

  factory SecVerifyUIConfigAndroid.fromJson(Map<String, dynamic> json) =>
      _$SecVerifyUIConfigAndroidFromJson(json);
  Map<String, dynamic> toJson() => _$SecVerifyUIConfigAndroidToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomLoginBtn {
  String? loginBtnImgIdName;
  String? loginImgPressedName;
  String? loginImgNormalName;
  String? loginBtnTextIdName;
  String? loginBtnTextColorIdName;
  int? loginBtnTextSize;
  int? loginBtnWidth;
  int? loginBtnHeight;
  int? loginBtnOffsetX;
  int? loginBtnOffsetY;
  int? loginBtnOffsetBottomY;
  int? loginBtnOffsetRightX;
  bool? loginBtnAlignParentRight;
  bool? loginBtnHidden;
  String? loginBtnText;
  bool? loginBtnTextBold;

  AndroidCustomLoginBtn() {}

  factory AndroidCustomLoginBtn.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomLoginBtnFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomLoginBtnToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomNav {
  String? navColorIdName;
  String? navTextIdName;
  String? navTextColorIdName;
  bool? navHidden;
  bool? navTransparent;
  bool? navCloseImgHidden;
  int? navTextSize;
  String? navCloseImgPath;
  int? navCloseImgWidth;
  int? navCloseImgHeight;
  int? navCloseImgOffsetX;
  int? navCloseImgOffsetRightX;
  int? navCloseImgOffsetY;
  bool? navTextBold;
  ImageScaleType? navCloseImgScaleType;

  AndroidCustomNav() {}

  factory AndroidCustomNav.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomNavFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomNavToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomAuthPage {
  String? backgroundImgPath;
  bool? backgroundClickClose;
  bool? fullScreen;
  bool? virtualButtonTransparent;
  bool? immersiveTheme;
  bool? immersiveStatusTextColorBlack;

  AndroidCustomAuthPage() {}

  factory AndroidCustomAuthPage.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomAuthPageFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomAuthPageToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomAuthPageLogo {
  String? logoImgPath;
  int? logoWidth;
  int? logoHeight;
  int? logoOffsetX;
  int? logoOffsetY;
  int? logoOffsetBottomY;
  int? logoOffsetRightX;
  bool? logoAlignParentRight;
  bool? logoHidden;

  AndroidCustomAuthPageLogo() {}

  factory AndroidCustomAuthPageLogo.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomAuthPageLogoFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomAuthPageLogoToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomPhoneNumber {
  String? numberColorIdName;
  int? numberSize;
  int? numberOffsetX;
  int? numberOffsetY;
  int? numberOffsetBottomY;
  int? numberOffsetRightX;
  bool? numberAlignParentRight;
  bool? numberHidden;
  bool? numberBold;

  AndroidCustomPhoneNumber() {}

  factory AndroidCustomPhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomPhoneNumberFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomPhoneNumberToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomSwitchNumber {
  String? switchAccColorIdName;
  int? switchAccTextSize;
  bool? switchAccHidden;
  int? switchAccOffsetX;
  int? switchAccOffsetY;
  int? switchAccOffsetBottomY;
  int? switchAccOffsetRightX;
  bool? switchAccAlignParentRight;
  String? switchAccText;
  bool? switchAccTextBold;

  AndroidCustomSwitchNumber() {}

  factory AndroidCustomSwitchNumber.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomSwitchNumberFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomSwitchNumberToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomCheckBox {
  String? checkboxImgIdName;
  bool? checkboxDefaultState;
  bool? checkboxHidden;
  int? checkboxOffsetX;
  int? checkboxOffsetRightX;
  int? checkboxOffsetY;
  int? checkboxOffsetBottomY;
  String? checkboxScaleX;
  String? checkboxScaleY;
  String? checkedImgName;
  String? uncheckedImgName;
  int? checkboxWidth;
  int? checkboxHeight;

  AndroidCustomCheckBox() {}

  factory AndroidCustomCheckBox.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomCheckBoxFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomCheckBoxToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomPrivacy {
  String? agreementColor;
  int? agreementOffsetX;
  int? agreementOffsetRightX;
  int? agreementOffsetY;
  int? agreementOffsetBottomY;
  bool? agreementGravityLeft;
  String? agreementBaseTextColor;
  int? agreementTextSize;
  String? agreementTextStartIdName;
  String? agreementTextEndIdName;
  bool? agreementAlignParentRight;
  bool? agreementHidden;
  String? agreementCmccTextString;
  String? agreementCuccTextString;
  String? agreementCtccTextString;
  String? agreementTextStartString;
  String? agreementTextAndString1;
  String? agreementTextAndString2;
  String? agreementTextAndString3;
  String? agreementTextEndString;
  bool? agreementTextBold;
  bool? agreementTextWithUnderLine;
  String? cusAgreementNameId1;
  String? cusAgreementUrl1;
  String? cusAgreementColor1;
  String? cusAgreementNameId2;
  String? cusAgreementUrl2;
  String? cusAgreementColor2;
  String? cusAgreementNameId3;
  String? cusAgreementUrl3;
  String? cusAgreementColor3;
  String? cusAgreementNameText1;
  String? cusAgreementNameText2;
  String? cusAgreementNameText3;
  int? agreementUncheckHintType;
  String? agreementUncheckHintText;

  AndroidCustomPrivacy() {}

  factory AndroidCustomPrivacy.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomPrivacyFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomPrivacyToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomPrivacyContentPage {
  String? agreementPageTitleString;
  String? cusAgreementPageOneTitleString;
  String? cusAgreementPageTwoTitleString;
  String? cusAgreementPageThreeTitleString;
  String? agreementPageTitleStringId;
  String? cusAgreementPageOneTitleNameId;
  String? cusAgreementPageTwoTitleNameId;
  String? cusAgreementPageThreeTitleNameId;
  String? agreementPageCloseImg;
  bool? agreementPageCloseImgHidden;
  int? agreementPageCloseImgWidth;
  int? agreementPageCloseImgHeight;
  int? agreementPageTitleTextSize;
  String? agreementPageTitleTextColor;
  bool? agreementPageTitleTextBold;
  bool? agreementPageTitleHidden;

  AndroidCustomPrivacyContentPage() {}

  factory AndroidCustomPrivacyContentPage.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomPrivacyContentPageFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AndroidCustomPrivacyContentPageToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomOperatorSlogan {
  int? sloganOffsetX;
  int? sloganOffsetY;
  int? sloganOffsetBottomY;
  int? sloganTextSize;
  String? sloganTextColor;
  int? sloganOffsetRightX;
  bool? sloganAlignParentRight;
  bool? sloganHidden;
  bool? sloganTextBold;

  AndroidCustomOperatorSlogan() {}

  factory AndroidCustomOperatorSlogan.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomOperatorSloganFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomOperatorSloganToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomDialog {
  bool? dialogTheme;
  bool? dialogAlignBottom;
  int? dialogOffsetX;
  int? dialogOffsetY;
  int? dialogWidth;
  int? dialogHeight;
  bool? dialogBackgroundClickClose;
  String? dialogBackground;

  AndroidCustomDialog() {}

  factory AndroidCustomDialog.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomDialogFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomDialogToJson(this);
}

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
class AndroidCustomView {
  String? viewTag;
  String? viewClass;
  String? viewText;
  String? viewTextColor;
  int? viewTextFont;
  bool? viewTextBold;
  bool? viewAlignParentRight;
  bool? viewHorizontalCenter;
  bool? viewHorizontalCenterVertical;
  int? viewOffsetX;
  int? viewOffsetY;
  int? viewOffsetRightX;
  int? viewOffsetBottomY;
  int? viewWidth;
  int? viewHeight;
  String? viewImg;

  AndroidCustomView() {}

  factory AndroidCustomView.fromJson(Map<String, dynamic> json) =>
      _$AndroidCustomViewFromJson(json);
  Map<String, dynamic> toJson() => _$AndroidCustomViewToJson(this);
}

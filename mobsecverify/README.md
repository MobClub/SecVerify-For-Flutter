# SecVerify For Flutter

### 运营商网关取号，一秒验证手机号

**支持的原生SDK版本**

- [Android](https://github.com/MobClub/SecVerify-for-Android) - V2.1.0
- [iOS](https://github.com/MobClub/SecVerify-for-iOS) - V2.1.2

**简介：** http://www.mob.com/product/secverify

**插件主页：** https://pub.dartlang.org/packages/secverify_plugin

**官网文档：** https://www.mob.com/wiki/detailed?wiki=miaoyan_chanpinjianjie&id=78

1.Flutter集成文档 [SecVerify-For-Flutter 在线文档](https://pub.dartlang.org/packages/secverify#-installing-tab-)
2.iOS平台配置参考 [iOS集成文档](http://wiki.mob.com/快速集成-11/)

- 实现 "一、注册应用获取appKey 和 appSecret"
- 实现 "三、配置appkey和appSecret"

3.Android平台集成

#####导入SMSSDK相关依赖
1. 在项目根目录的build.gradle中添加以下代码：

```
    dependencies {
        classpath 'com.android.tools.build:gradle:3.2.1'
        classpath 'com.mob.sdk:MobSDK:+'
    }
```
2. 在/android/app/build.gradle中添加以下代码：

```
apply plugin: 'com.android.application'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
// 导入MobSDK
apply plugin: 'com.mob.sdk'
MobSDK {
   appKey "替换为mob官方申请的appkey"
   appSecret "替换为mob官方申请的appkey对应的appSecret"
   SecVerify {}
}
```
3. 在根路径下的pubspec.yaml文件中添加secverify flutter插件：

```
dependencies:
  secverify_plugin:^1.30.7
```

在你项目的Dart中添加以下代码：

```
 import 'package:secverify_plugin/secverify.dart'
```
这样，就可以使用plugin中定义的dart api了。

4. 平台相关集成
在项目的/android/app/build.gradle中添加:

```
android {
    // lines skipped
    dependencies {
        provided rootProject.findProject(":secverify")
    }
}
```

这样就可以在你的`project/android/src`下的类中`import com.mob.flutter.secverify.SecverifyPlugin`并使用`SecverifyPlugin`中的api了。

######添加代码
1. 在MainActivity的onCreate中添加以下代码：

```
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // 注册SecVerify Flutter插件
    SecverifyPlugin.registerWith(registrarFor(SecverifyPlugin.CHANNEL));
    // 初始化SecVerify
    MobSDK.init(this, MOB_APPKEY, MOB_APPSECRET);
  }
```

## 技术支持
如有问题请联系技术支持:
```
服务电话:   400-685-2216
QQ:        4006852216
节假日值班电话:
    iOS：185-1664-1951
Android: 185-1664-1950
电子邮箱:   support@mob.com
市场合作:   021-54623100
```
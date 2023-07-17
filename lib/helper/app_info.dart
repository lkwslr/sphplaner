import 'package:package_info_plus/package_info_plus.dart';

String? appName;
String? packageName;
String? version;
String? buildNumber;

Future<void> init() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;
}

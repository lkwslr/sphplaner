import 'package:package_info_plus/package_info_plus.dart';

late String appName;
late String packageName;
late String version;
late String buildNumber;

Future<void> init() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;
}

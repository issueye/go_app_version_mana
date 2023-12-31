import 'package:go_app_version_mana/init/windows.dart';
import 'package:go_app_version_mana/utils/db/config.dart';
import 'package:go_app_version_mana/utils/log/logger.dart';
import 'package:go_app_version_mana/utils/request/services.dart';

init() async {
  await initWindowsManager();
  initLogging('fltter_3.0_template');
  await ConfigDB.initDb();

  // 设置 DIO baseUrl
  var serverHost = await ConfigDB.getStr('server_host');
  DioSingleton.baseUrl = serverHost;
}

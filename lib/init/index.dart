import 'package:go_app_version_mana/init/windows.dart';
import 'package:go_app_version_mana/utils/log/logger.dart';

init() async {
  await initWindowsManager();
  initLogging('fltter_3.0_template');
}

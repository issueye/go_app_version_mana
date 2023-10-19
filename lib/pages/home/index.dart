import 'package:go_app_version_mana/components/menu/menu.dart';
import 'package:go_app_version_mana/pages/about/index.dart';
import 'package:go_app_version_mana/pages/home/win_title.dart';
import 'package:go_app_version_mana/pages/login/index.dart';
import 'package:go_app_version_mana/pages/manage/index.dart';
import 'package:go_app_version_mana/pages/settings/index.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 主菜单
  final List<MenuItemData> menus = [
    MenuItemData('程序', Icons.apps, Icons.apps_outlined),
  ];

  // 其他菜单
  final List<MenuItemData> footers = [
    MenuItemData('设置', Icons.settings, Icons.settings_outlined),
    MenuItemData('关于', Icons.question_answer, Icons.question_answer_outlined),
  ];

  final PageController _selectControl = PageController();

  final List pages = [
    const PageManage(),
    const SettingsPage(),
    const AboutPage(),
  ];

  Logger log = Logger('home-> index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WinTitle(),
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  NavMenu(
                    width: 120,
                    onSelect: (index, type) {
                      debugPrint('select now = $index type = $type');
                      log.info('select now = $index type = $type');
                      if (type == MenuOperationType.main) {
                        _selectControl.jumpToPage(index);
                      } else {
                        _selectControl.jumpToPage(index + menus.length);
                      }
                    },
                    menuList: menus,
                    footerList: footers,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _selectControl,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

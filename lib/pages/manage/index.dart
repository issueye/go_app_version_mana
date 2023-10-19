import 'package:go_app_version_mana/components/custom_button.dart';
import 'package:go_app_version_mana/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class PageManage extends StatefulWidget {
  const PageManage({super.key});

  @override
  State<PageManage> createState() => _PageManageState();
}

class _PageManageState extends State<PageManage> {
  final TextEditingController _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child:
                      CustomTextField(controller: _query, hintText: '请输入查询内容'),
                ),
                const SizedBox(width: 20),
                CustomButton(onPressed: () {}, name: '查询'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

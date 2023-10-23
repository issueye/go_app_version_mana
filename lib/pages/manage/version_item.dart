import 'package:flutter/material.dart';
import 'package:go_app_version_mana/model/version_info/datum.dart';
import 'package:go_app_version_mana/utils/app_theme.dart';

class VersionItem extends StatefulWidget {
  const VersionItem({super.key, required this.data});
  final Datum data;

  @override
  State<VersionItem> createState() => _VersionItemState();
}

class _VersionItemState extends State<VersionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          Text(widget.data.appName!, style: AppTheme.defaultTextStyle),
          Expanded(
              child: SizedBox(
            width: 280,
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _feild(widget.data.version!, 100),
                  _feild(widget.data.createAt!, 100),
                  _feild(widget.data.content!, 100),
                ],
              ),
            ),
          )),
        ],
      ),
    );

    // return Row(
    //   children: [
    //     Text('123', style: AppTheme.defaultTextStyle),
    // Expanded(
    //   child: SizedBox(
    //     height: 40,
    //     child: Row(
    //       children: [
    //         Container(
    //           width: 400,
    //           child: ListView(
    //             scrollDirection: Axis.horizontal,
    //             children: [
    //               _feild(widget.data.appName!),
    //               // _feild(widget.data.version!),
    //               // _feild(widget.data.createAt!),
    //               // _feild(widget.data.content!),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    // ],
    // );
  }

  _feild(String data, double width) {
    return Container(
      width: width,
      decoration: const BoxDecoration(),
      child: Expanded(
        child: Text(
          data,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

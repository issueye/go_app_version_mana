import 'package:go_app_version_mana/utils/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomSelect extends StatefulWidget {
  const CustomSelect(
      {Key? key,
      this.hint,
      this.validText,
      required this.data,
      this.onChanged,
      required this.selectData})
      : super(key: key);
  final String? hint;
  final String? validText;
  final Map<String, dynamic> data;
  final Function(dynamic)? onChanged;
  final TextEditingController selectData;

  @override
  // ignore: library_private_types_in_public_api
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  @override
  Widget build(BuildContext context) {
    Text hintText = widget.hint == null ? const Text('') : Text(widget.hint!);

    List items = [];
    // 将 map 转化为 list
    widget.data.forEach((key, value) {
      items.add(value);
    });

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: AppTheme.defaultTextFieldHeight,
      ),
      child: DropdownButtonFormField2(
        isExpanded: true,
        decoration: const InputDecoration(
          isCollapsed: true,
          contentPadding: AppTheme.defaultTextFieldContentPadding,
          border: OutlineInputBorder(
            borderRadius: AppTheme.mainRadius,
          ),
          // 聚焦时的边框
          focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: AppTheme.mainColor,
            ),
            borderRadius: AppTheme.mainRadius,
          ),
          // 失去焦点时的边框
          enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: AppTheme.enabledColor,
            ),
            borderRadius: AppTheme.mainRadius,
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: AppTheme.errorContentTextColor,
            ),
            borderRadius: AppTheme.mainRadius,
          ),
        ),
        hint: hintText,
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: AppTheme.defaultTextStyle,
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return widget.validText == null ? '' : widget.validText!;
          }
          return null;
        },
        dropdownStyleData: const DropdownStyleData(
          offset: Offset(1, -10),
          decoration: BoxDecoration(
            borderRadius: AppTheme.mainRadius,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          height: 28,
        ),
        onChanged: widget.onChanged,
        customButton: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectData.text == ''
                    ? widget.hint!
                    : widget.selectData.text,
                style: AppTheme.defaultTextStyle,
              ),
              widget.selectData.text == ''
                  ? const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: AppTheme.defaultContentTextColor,
                    )
                  : InkWell(
                      onTap: () {
                        widget.selectData.text = '';
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.close_outlined,
                        size: 15,
                        color: AppTheme.defaultContentTextColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputWidget extends StatelessWidget {
  const FormInputWidget({Key? key,
    this.hint,
    required this.onChange,
    required this.onSubmit,
    required this.controller,
    this.onTap,
    this.isShowTitle=false,
    this.title,
    this.readOnly = false,
    this.isObscureText = false,
    this.textInputType = TextInputType.text,
    this.textInputFormatter,
    this.maxLength = 5000,
  }) : super(key: key);

  final Function()? onTap;
  final String? hint;
  final Function(String value) onChange;
  final Function(String value) onSubmit;
  final bool isShowTitle;
  final String? title;
  final TextEditingController controller;
  final bool readOnly;
  final bool isObscureText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(isShowTitle) _itemTitleWidget(),
          TextFormField(
            onTap: () {
              if(readOnly && onTap != null){
                onTap!();
              }
            },
            maxLength: maxLength,
            obscureText: isObscureText,
            readOnly: readOnly,
            controller: controller,
            style: regular12TextStyle,
            keyboardType: textInputType,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            inputFormatters: textInputFormatter,
            decoration: InputDecoration(
              counterText: "",
              isDense: true,
              contentPadding: const EdgeInsets.all(15),
              hintText: hint ?? '',
              hintStyle: regular12TextStyle.copyWith(color: gray_999Color),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Color(0xffD5D7DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemTitleWidget() => Container(
    margin: const EdgeInsets.only(bottom: 8),
    child: Text(title ?? '', style: medium14TextStyle,)
  );
}

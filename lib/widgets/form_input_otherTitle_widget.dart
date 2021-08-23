import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class FormInputTitleWidget extends StatelessWidget {
  const FormInputTitleWidget({Key? key,
    this.hint,
    required this.onChange,
    required this.onSubmit,
    required this.controller,
    this.isShowTitle=false,
    required this.title,
    this.readOnly = false,
    this.isObscureText = false,
    this.textInputType = TextInputType.text
  }) : super(key: key);

  final String? hint;
  final Function(String value) onChange;
  final Function(String value) onSubmit;
  final bool isShowTitle;
  final Widget title;
  final TextEditingController controller;
  final bool readOnly;
  final bool isObscureText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(isShowTitle) title,
          const SizedBox(height: 8),
          TextFormField(
            obscureText: isObscureText,
            readOnly: readOnly,
            controller: controller,
            style: regular12TextStyle,
            keyboardType: textInputType,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            decoration: InputDecoration(
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
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/styles_manager.dart';

class TxtForm extends StatelessWidget {
  const TxtForm(
      {Key? key,
        required this.textHeader,
        required this.editingController,
        this.textFieldHint = "",
        this.inputAction = TextInputAction.next,
        this.obscure = false,
        this.validator,
        this.autofillHints,
        this.keyboardType,
        this.fillColor = Colors.white,
        this.inputFormatters,
        this.validateMode = AutovalidateMode.onUserInteraction, this.suffixIcon})
      : super(key: key);
  final Widget textHeader;
  final String textFieldHint;
  final bool obscure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextEditingController editingController;
  final TextInputType? keyboardType;
  final Color fillColor;
  final AutovalidateMode validateMode;
  final TextInputAction inputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: textHeader
        ),
        const SizedBox(height: 10,),
        TextFormField(
          enableSuggestions: true,
          textInputAction: inputAction,
          obscureText: obscure,
          autofillHints: autofillHints,
          autovalidateMode: validateMode,
          controller: editingController,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          cursorColor: ColorManager.secondary,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: textFieldHint,
              hintStyle: getLightStyle(color: ColorManager.grey.withOpacity(0.5),fontSize: FontSize.s14),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                borderSide: BorderSide(
                    width: 1,
                    color: ColorManager.secondary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                borderSide: BorderSide(
                    width: 1, color: ColorManager.lightGrey),
              ),
              errorStyle: TextStyle(color: ColorManager.errorColor),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(10.0),
                borderSide: const BorderSide(),
              ),
              fillColor: fillColor,
              filled: true,
          ),
        ),
      ],
    );
  }
}
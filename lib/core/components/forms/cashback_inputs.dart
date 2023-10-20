import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon(
      {Key? key,
      required this.controller,
      required this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.clearIconSuffix = true,
      this.keyboardType = TextInputType.text,
      this.textInputAction,
      this.focusNode,
      this.obscureText = false,
      this.enabled = true,
      this.readOnly = false,
      this.minLines = 1,
      this.maxLines,
      this.inputFormatters,
      required this.onChanged,
      required this.onSaved,
      this.onEditingComplete,
      this.hasNewIcon = false,
      this.onFieldSubmitted,
      this.styleMain,
      this.sizeIcon = 21,
      this.paddingIcon = 0,
      this.inputBorder,
      this.newIcon = Icons.abc,
      this.iconFunction,
      this.enabledBorder,
      this.focusedBorder,
      this.autofocus = false})
      : super(key: key);

  final TextEditingController controller;
  final IconData? iconPrefix;
  final TextStyle? styleMain;
  final bool clearIconSuffix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final InputBorder? inputBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool autofocus;
  final bool hasNewIcon;
  final double? sizeIcon;
  final double? paddingIcon;
  final IconData? newIcon;
  final Function()? iconFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        cursorColor: CashbackThemes.primaryRegular,
        style: styleMain,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          border: inputBorder,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CashbackThemes.error),
          ),
          disabledBorder: inputBorder,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CashbackThemes.secundaryText),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CashbackThemes.secundaryText),
          ),
          prefixIcon: iconPrefix == null
              ? const Padding(
                  padding: EdgeInsets.only(top: 28),
                  child: Text(
                    'Cb\$',
                    style: TextStyle(fontSize: 33),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: paddingIcon!),
                  child: Icon(
                    iconPrefix,
                    size: sizeIcon,
                  ),
                ),
          floatingLabelStyle: const TextStyle(fontSize: 15),
          labelText: labelText,
          labelStyle: const TextStyle(),
          suffixIcon: hasNewIcon
              ? IconButton(
                  icon: Icon(newIcon, size: 21),
                  onPressed: iconFunction,
                )
              : clearIconSuffix
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 21),
                      onPressed: () {
                        controller.clear();
                      },
                    )
                  : null,
        ),
        autofocus: autofocus,
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        minLines: minLines,
        validator: validator,
        enabled: enabled,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        readOnly: readOnly,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

Widget rTextField({
  TextEditingController? textEditingController,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  VoidCallback? onPressedIconSuffix,
  TextInputType? keyboardType = TextInputType.emailAddress,
  bool obscureText = false,
  bool filled = false,
  bool readOnly = false,
  Color fillColor = Colors.white,
  String? labelText,
  String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  List<TextInputFormatter>? inputFormatters,
  double contentPaddingHorizontal = 5,
  double contentPaddingVertical = 20,
  double topLeft = 20,
  double topRight = 20,
  double bottomLeft = 20,
  double bottomRight = 20,
}) =>
    TextFormField(
      inputFormatters: inputFormatters,
      controller: textEditingController,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal,
            vertical: contentPaddingVertical),
        filled: filled,
        fillColor: fillColor,
        labelText: labelText ?? '',
        hintText: hintText ?? '',
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onPressedIconSuffix,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
        ),
      ),
    );

Widget rMaterialButton({
  @required VoidCallback? onPressed,
  @required Widget? child,
  VoidCallback? onLongPress,
  double? height,
  Color? color,
  Color? splashColor = kAppMainColor,
  double? radius = 15,
  double? horizontal = 5,
  double? vertical = 5,
  double? elevation = 5,
}) =>
    MaterialButton(
      onPressed: onPressed,
      height: height,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
      splashColor: splashColor,
      elevation: elevation,
      onLongPress: onLongPress,
      child: child,
    );

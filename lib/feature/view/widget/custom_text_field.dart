import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.suffixPath,
      this.isPassword = false,
      this.isEmail = false,
      this.controller,
      this.validation})
      : super(key: key);

  final String label;
  final String suffixPath;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController? controller;
  final Function(String)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      obscureText: isPassword ? true : false,
      enableSuggestions: isPassword ? false : true,
      autocorrect: isPassword ? false : true,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(suffixPath),
        ),
      ),
      validator: validation == null
          ? (e) {
              return null;
          }
          : (e) {
              return validation!(e.toString());
            },
    );
  }
}

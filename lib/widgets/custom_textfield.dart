import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.onSaved,
    required this.iconData,
    this.obscureText = false,
    required this.validator,
    this.isNormal = true,
    this.keyboardType = TextInputType.text,
    this.initialValue = "",
  }) : super(key: key);

  final String labelText;
  final IconData iconData;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final bool isNormal;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(isNormal ? 14 : 70),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: iconData != null
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.pink[300]!,
                            Colors.orange[300]!,
                          ])),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

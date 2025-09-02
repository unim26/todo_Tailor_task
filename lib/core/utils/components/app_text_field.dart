import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.suffix,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? suffix;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      keyboardType: keyboardType,
      cursorErrorColor: Colors.red,
      cursorOpacityAnimates: true,
      cursorRadius: Radius.circular(15),

      decoration: InputDecoration(
        filled: true,
        // fillColor: Theme.of(context).colorScheme.tertiary,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hintText,
        suffix: suffix,
      ),
    );
  }
}

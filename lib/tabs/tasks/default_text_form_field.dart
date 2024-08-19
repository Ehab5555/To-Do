import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class DefaultTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final bool isPassword;
  final String? Function(String?)? validator;

  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      this.maxLines = 1,
      this.validator});

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider provider = Provider.of<TasksProvider>(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: isObsecure,
      style: TextStyle(
        color: provider.isDark
            ? AppTheme.white.withOpacity(0.6)
            : AppTheme.black.withOpacity(0.6),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObsecure = !isObsecure;
                  setState(() {});
                },
                icon: Icon(
                  isObsecure ? Icons.visibility_outlined : Icons.visibility_off,
                ),
              )
            : null,
        hintStyle: TextStyle(
          color: provider.isDark
              ? AppTheme.white.withOpacity(0.6)
              : AppTheme.black.withOpacity(0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: provider.isDark
                ? AppTheme.white.withOpacity(0.6)
                : AppTheme.black.withOpacity(0.6),
          ),
        ),
      ),
      maxLines: widget.maxLines,
      validator: widget.validator,
    );
  }
}

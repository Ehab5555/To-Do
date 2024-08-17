import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class DefaultTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  int? maxLines;
  String? Function(String?)? validator;

  DefaultTextFormField(
      {required this.controller,
      required this.hintText,
      this.maxLines,
      this.validator});

  @override
  Widget build(BuildContext context) {
    TasksProvider provider = Provider.of<TasksProvider>(context);
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: provider.isDark
            ? AppTheme.white.withOpacity(0.6)
            : AppTheme.black.withOpacity(0.6),
      ),
      decoration: InputDecoration(
        hintText: hintText,
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
      maxLines: maxLines,
      validator: validator,
    );
  }
}

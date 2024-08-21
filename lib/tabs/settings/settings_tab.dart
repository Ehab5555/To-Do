import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider provider = Provider.of<TasksProvider>(context);
    ThemeData theme = Theme.of(context);
    AppLocalizations? localizations = AppLocalizations.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(children: [
          Container(
            height: screenHeight * 0.2,
            width: double.infinity,
            color: AppTheme.primary,
          ),
          Positioned.directional(
            top: screenHeight * 0.05,
            start: screenHeight * 0.05,
            textDirection: provider.language == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Text(
              localizations!.settings,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 22,
                color: provider.isDark ? AppTheme.black : AppTheme.white,
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDark ? localizations.dark : localizations.light,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: provider.isDark ? AppTheme.white : AppTheme.black,
                    ),
                  ),
                  Switch(
                    value: provider.isDark,
                    onChanged: (_) {
                      if (provider.isDark) {
                        provider.changeMode(ThemeMode.light);
                      } else {
                        provider.changeMode(ThemeMode.dark);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.language,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: provider.isDark ? AppTheme.white : AppTheme.black,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: provider.language,
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            'English',
                            style: theme.textTheme.titleSmall?.copyWith(
                                color: provider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text(
                            'العربية',
                            style: theme.textTheme.titleSmall?.copyWith(
                                color: provider.isDark
                                    ? AppTheme.white
                                    : AppTheme.black),
                          ),
                        ),
                      ],
                      onChanged: (lang) {
                        if (lang == null) return;
                        provider.changeLang(lang);
                      },
                      dropdownColor: provider.isDark
                          ? AppTheme.bottomNavBarBackground
                          : AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

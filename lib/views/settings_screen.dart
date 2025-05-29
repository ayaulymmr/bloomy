import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.color_lens),
            title: const Text('Тёмная тема'),
            value: isDarkMode,
            onChanged: (val) => themeProvider.toggleTheme(val),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Язык'),
            subtitle: Text(localeProvider.locale.languageCode == 'ru' ? 'Русский' : 'English'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Выберите язык'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        localeProvider.setLocale('ru');
                        Navigator.pop(context);
                      },
                      child: const Text('Русский'),
                    ),
                    TextButton(
                      onPressed: () {
                        localeProvider.setLocale('en');
                        Navigator.pop(context);
                      },
                      child: const Text('English'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Уведомления'),
            subtitle: const Text('Скоро будут доступны'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Изменить пароль'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Функция будет добавлена позже')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('О приложении'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Bloomy',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Bloomy',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Выйти из аккаунта'),
            onTap: () {
              // TODO: если используешь Firebase — сделать FirebaseAuth.instance.signOut()
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Вы вышли из аккаунта')),
              );
            },
          ),
        ],
      ),
    );
  }
}

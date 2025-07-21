import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/user.dart';
import 'package:kendin_ye/main.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final User user;
  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isRealistic;
  late String _languageCode;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only initialize once, when context is available
    if (!_initialized) {
      _initialized = true;
      // 1) Get current theme mode from your appState:
      _isRealistic = appKey.currentState?.themeMode == ThemeMode.dark;
      // 2) Read the active locale from Flutter's localization:
      _languageCode = Localizations.localeOf(context).languageCode;
    }
  }

  void _toggleRealistic(bool value) {
    setState(() => _isRealistic = value);
    appKey.currentState?.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void _changeLanguage(String? code) {
    if (code == null) return;
    setState(() => _languageCode = code);
    appKey.currentState?.setLocale(Locale(code));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context).translate;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t('settings')),
        backgroundColor: theme.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Realistic / Cartoon Theme
          ListTile(
            leading: Icon(
              _isRealistic ? Icons.nightlight_round : Icons.wb_sunny,
              color: theme.primaryColor,
            ),
            title: Text(t('realistic')),
            subtitle: Text(
              _isRealistic ? t('dark_theme') : t('light_theme'),
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
            trailing: Switch(
              value: _isRealistic,
              activeColor: theme.primaryColor,
              onChanged: _toggleRealistic,
            ),
          ),
          const Divider(),

          // Language selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              t('language'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: _languageCode,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: [
                DropdownMenuItem(value: 'en', child: Text(t('english'))),
                DropdownMenuItem(value: 'tr', child: Text(t('turkish'))),
              ],
              onChanged: _changeLanguage,
            ),
          ),
          const Divider(),

          // Change Password
          ListTile(
            leading: Icon(Icons.lock, color: theme.primaryColor),
            title: Text(t('change_password')),
            onTap: () async {
              // Push the ChangePasswordScreen, passing the current user
              final updatedUser =
                  await Navigator.of(
                        context,
                      ).pushNamed('/profile', arguments: widget.user)
                      as User?;
              // If the result is a non-null User, pop SettingsScreen with it
              if (updatedUser != null) {
                Navigator.of(context).pop(updatedUser);
              }
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(t('logout'), style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}

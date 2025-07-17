import 'package:flutter/material.dart';
import 'package:kendin_ye/presentation/screens/animated_burger.dart';
import 'package:kendin_ye/main.dart';
import 'package:kendin_ye/data/models/user.dart';
import '../../core/localization/app_localizations.dart';

class BurgerLoginScreen extends StatefulWidget {
  const BurgerLoginScreen({super.key});

  @override
  State<BurgerLoginScreen> createState() => _BurgerLoginScreenState();
}

class _BurgerLoginScreenState extends State<BurgerLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final t = AppLocalizations.of(context).translate;
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    final user = authenticateUser(username, password);
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/main', arguments: user);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t("invalid_credentials"))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context).translate;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7700),
        toolbarHeight: 50,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'cartoon') {
                appKey.currentState?.setThemeMode(ThemeMode.light);
              } else if (value == 'realistic') {
                appKey.currentState?.setThemeMode(ThemeMode.dark);
              } else if (value == 'en' || value == 'tr') {
                appKey.currentState?.setLocale(Locale(value));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'cartoon', child: Text(t('cartoon_theme'))),
              PopupMenuItem(
                value: 'realistic',
                child: Text(t('realistic_theme')),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(value: 'en', child: Text(t('english'))),
              PopupMenuItem(value: 'tr', child: Text(t('turkish'))),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Visibility(
                    visible: !isKeyboardOpen,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 230,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF7700),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(120),
                              bottomRight: Radius.circular(120),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          top: -30,
                          child: Center(child: Image.asset(t("logo_path"))),
                        ),
                        Positioned(
                          bottom: -110,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 240,
                            width: 240,
                            child: AnimatedBurger(
                              themeMode:
                                  appKey.currentState?.themeMode ??
                                  ThemeMode.light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isKeyboardOpen,
                    child: const SizedBox(height: 100),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    icon: Icons.person,
                    hint: t("username"),
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    icon: Icons.lock,
                    hint: t("password"),
                    obscure: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7700),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _login,
                    child: Text(
                      t("sign_in"),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t("forgot_password"),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.pushNamed(context, '/signup');
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      _usernameController.text = result['username']!;
                      _passwordController.text = result['password']!;
                    });
                  }
                },
                child: Text(
                  t("create_account"),
                  style: const TextStyle(
                    color: Color(0xFFFF7700),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hint,
    bool obscure = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF7700), width: 2),
          ),
        ),
      ),
    );
  }
}

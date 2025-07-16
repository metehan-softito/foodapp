import 'package:flutter/material.dart';
import 'package:kendin_ye/data/models/user.dart';
import '../../core/localization/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _acceptTerms = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _telController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final t = AppLocalizations.of(context).translate;
    if (_formKey.currentState!.validate() && _acceptTerms) {
      User newUser = User(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _telController.text.trim(),
        profileImage: "assets/images/profile_images/default_profile.png",
      );
      registerUser(newUser);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t('account_created'))));
      await Navigator.pushNamed(context, '/confirmation');
      Navigator.pop(context, {
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t('must_accept_terms'))));
    }
  }

  InputDecoration _inputDecoration(String key) {
    return InputDecoration(
      hintText: AppLocalizations.of(context).translate(key),
      hintStyle: const TextStyle(fontStyle: FontStyle.italic),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context).translate;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          Text(
                            t('create_account'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF7700),
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        decoration: _inputDecoration('username'),
                        validator: (value) =>
                            value!.isEmpty ? t('enter_username') : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: _inputDecoration('first_name'),
                        validator: (value) =>
                            value!.isEmpty ? t('enter_first_name') : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: _inputDecoration('last_name'),
                        validator: (value) =>
                            value!.isEmpty ? t('enter_last_name') : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _telController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration('phone_number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return t('enter_phone');
                          } else if (value.length < 10) {
                            return t('phone_too_short');
                          } else if (value.length > 15) {
                            return t('phone_too_long');
                          } else if (RegExp(r'^\d{10,15}\$').hasMatch(value)) {
                            return t('invalid_phone');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: _inputDecoration('password'),
                        validator: (value) => value != null && value.length >= 6
                            ? null
                            : t('password_min_length'),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: _inputDecoration('confirm_password'),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return t('password_mismatch');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() => _acceptTerms = value!);
                            },
                          ),
                          Expanded(
                            child: Text(
                              t('accept_terms'),
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submit,
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
                  child: Text(
                    t('sign_up'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

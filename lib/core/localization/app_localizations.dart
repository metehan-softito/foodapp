import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      //Logo
      'logo_path': 'assets/images/logos/eat_yourself.png',

      // Login screen
      'username': 'User Name',
      'password': 'Password',
      'sign_in': 'Sign In',
      'forgot_password': 'Forget Password?',
      'create_account': 'Create New Account',
      'cartoon_theme': 'Cartoon Theme',
      'realistic_theme': 'Realistic Theme',
      'english': 'English',
      'turkish': 'Türkçe',

      // Sign Up screen
      'first_name': 'First Name',
      'last_name': 'Last Name',
      'phone_number': 'Tel. Number',
      'confirm_password': 'Confirm Password',
      'accept_terms': 'I accept the policy and terms',
      'sign_up': 'Sign Up',
      'create_new_account': 'Create New Account',
      'enter_username': 'Please enter user name',
      'enter_first_name': 'Please enter first name',
      'enter_last_name': 'Please enter last name',
      'enter_phone': 'Enter phone number',
      'phone_too_short': 'Phone number is too short',
      'phone_too_long': 'Phone number is too long',
      'invalid_phone': 'Invalid phone number',
      'password_min_length': 'Password must be at least 6 characters',
      'passwords_mismatch': 'Passwords do not match',
      'must_accept_terms': 'You must accept the policy and terms.',
      'account_created': 'Account created successfully!',

      // Register Confirmation screen
      'registration_successful': 'Your account has\nbeen registered!',
      'welcome': 'Welcome to\nKendin Ye',
      'ok': 'OK',

      // Main screen
      'hello': 'Hello',
      'profile': 'Profile',
      'settings': 'Settings',
      'logout': 'Logout',
    },
    'tr': {
      //Logo
      'logo_path': 'assets/images/logos/kendin_ye.png',

      // Login screen
      'username': 'Kullanıcı Adı',
      'password': 'Şifre',
      'sign_in': 'Giriş Yap',
      'forgot_password': 'Şifrenizi mi unuttunuz?',
      'create_account': 'Yeni Hesap Oluştur',
      'cartoon_theme': 'Çizgi Film Teması',
      'realistic_theme': 'Gerçekçi Tema',
      'english': 'İngilizce',
      'turkish': 'Türkçe',

      // Sign Up screen
      'first_name': 'Ad',
      'last_name': 'Soyad',
      'phone_number': 'Telefon Numarası',
      'confirm_password': 'Şifreyi Onayla',
      'accept_terms': 'Politika ve şartları kabul ediyorum',
      'sign_up': 'Kayıt Ol',
      'create_new_account': 'Yeni Hesap Oluştur',
      'enter_username': 'Kullanıcı adı girin',
      'enter_first_name': 'Adınızı girin',
      'enter_last_name': 'Soyadınızı girin',
      'enter_phone': 'Telefon numarası girin',
      'phone_too_short': 'Telefon numarası çok kısa',
      'phone_too_long': 'Telefon numarası çok uzun',
      'invalid_phone': 'Geçersiz telefon numarası',
      'password_min_length': 'Şifre en az 6 karakter olmalı',
      'passwords_mismatch': 'Şifreler eşleşmiyor',
      'must_accept_terms': 'Politika ve şartları kabul etmelisiniz.',
      'account_created': 'Hesap başarıyla oluşturuldu!',

      // Register Confirmation screen
      'registration_successful': 'Hesabınız\nbaşarıyla oluşturuldu!',
      'welcome': 'Kendin Ye\'ye\nhoş geldiniz',
      'ok': 'TAMAM',

      // Main screen
      'hello': 'Hoşgeldin',
      'profile': 'Profil',
      'settings': 'Ayarlar',
      'logout': 'Çıkış Yap',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

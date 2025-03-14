import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appName => Intl.message('Takatuf', name: 'appName');
  String get signIn => Intl.message('Sign In', name: 'signIn');
  String get signUp => Intl.message('Sign Up', name: 'signUp');
  String get email => Intl.message('Email', name: 'email');
  String get password => Intl.message('Password', name: 'password');
  String get forgotPassword => Intl.message('Forgot your Password?', name: 'forgotPassword');
  String get welcomeMessage => Intl.message('Welcome back, please sign in.', name: 'welcomeMessage');
  String get home => Intl.message('Home', name: 'home');
  String get signInToAccount => Intl.message('Sign in to your account', name: 'signInToAccount');
  String get createAccount => Intl.message('Create an Account', name: 'createAccount');
  String get fullName => Intl.message('Full Name', name: 'fullName');
  String get confirmPassword => Intl.message('Confirm Password', name: 'confirmPassword');
  String get userType => Intl.message('User Type', name: 'userType');
  String get pleaseFillFields => Intl.message('Please fill in all fields!', name: 'pleaseFillFields');
  String get passwordWeak => Intl.message('Password must be at least 6 characters long!', name: 'passwordWeak');
  String get passwordMismatch => Intl.message('Passwords do not match!', name: 'passwordMismatch');
  String get registrationFailed => Intl.message('Registration Failed', name: 'registrationFailed');
  String get errorOccurred => Intl.message('An error occurred', name: 'errorOccurred');
  String get emailAlreadyInUse => Intl.message('This email is already registered.', name: 'emailAlreadyInUse');

}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations());
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

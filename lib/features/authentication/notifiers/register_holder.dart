import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kafil/features/authentication/models/app_dependencies.dart';

class RegisterHolder extends ChangeNotifier {
  static final provider = ChangeNotifierProvider(
    (ref) => RegisterHolder(),
  );

  int _currentStep = 0;

  int _currentSalary = 100;

  int get currentSalary => _currentSalary;

  int _currentGender = -1;

  int get currentGender => _currentGender;

  List<num> _skills = [];

  List<num> get skills => _skills;

  set skills(List<num> value) {
    _skills = value;
    notifyListeners();
  }

  List<String> _social = [];

  List<String> get social => _social;

  set social(List<String> value) {
    _social = value;
    notifyListeners();
  }

  set currentGender(int value) {
    _currentGender = value;
    _isMale = (value == 0);
    notifyListeners();
  }

  bool _isMale = true;

  bool get isMale => _isMale;

  set currentSalary(int value) {
    if (value >= 100 && value <= 1000) {
      _currentSalary = value;
    }
    notifyListeners();
  }

  void incrementSalary() {
    int newSalary = _currentSalary + 100;
    currentSalary = newSalary;
    notifyListeners();
  }

  void decrementSalary() {
    int newSalary = _currentSalary - 100;
    currentSalary = newSalary;
    notifyListeners();
  }

  int get currentStep => _currentStep;

  File? _file;

  File? get file => _file;

  set file(File? value) {
    _file = value;
    notifyListeners();
  }

  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  num _userType = -20;

  num get userType => _userType;

  set userType(num value) {
    _userType = value;
    notifyListeners();
  }

  Dependency? _dependency;

  Dependency? get dependency => _dependency;

  set dependency(Dependency? value) {
    _dependency = value;
    notifyListeners();
  }

  bool _showError = false;

  bool get showError => _showError;

  set showError(bool value) {
    _showError = value;
    notifyListeners();
  }

  bool isFirstFormValid() =>
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty &&
      _userType != -20;

  bool isSecondFormValid() =>
      aboutController.text.isNotEmpty &&
      dateController.text.isNotEmpty &&
      currentGender != -1 &&
      file != null &&
      skills.isNotEmpty &&
      social.isNotEmpty;

  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final aboutController = TextEditingController();
  final dateController = TextEditingController();
}

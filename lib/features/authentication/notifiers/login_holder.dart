import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginHolder extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose(
    (ref) => LoginHolder(),
  );

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool shouldRememberMe = true;
}

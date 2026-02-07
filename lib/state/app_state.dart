import 'package:flutter/foundation.dart';

class AppState {
  AppState._();
  static final AppState I = AppState._();

  final ValueListenable<String?> serviceType = ValueNotifier<String?>(null);

  void setServiceType(String? value) {
    (serviceType as ValueNotifier<String?>).value = value;
  }
}


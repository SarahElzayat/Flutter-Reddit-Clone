/// this file is used to get the real ui library in flutter web
/// date: 16/12/2022
/// @Author: Ahmed Atta
import 'dart:ui' as ui;

/// this class is used to get the real ui library in flutter web
class PlatformViewRegistry {
  static void registerViewFactory(String viewId, dynamic cb) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}

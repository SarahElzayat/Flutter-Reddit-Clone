import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

/// This is used to in backend
/// Note : This is Simple Way that I used to make sure that the UI work Fine
/// And This Will be changed and used Bloc instead

class GlobalVarible {
  static ValueNotifier<bool> isEmpty = ValueNotifier(true);
  static ValueNotifier<List<XFile>> images = ValueNotifier(<XFile>[]);
  static ValueNotifier<bool> isPainted = ValueNotifier(false);
  static ValueNotifier<XFile?> video = ValueNotifier(null);
  static ValueNotifier<Uint8List?> videoThumbnail = ValueNotifier(null);
  static ValueNotifier<int> postType = ValueNotifier(-1);
}

import 'dart:collection';

import 'package:bpcheck/utils/widget_types.dart';

import '../interfaces/widget_operations.dart';
import '../shared/custom_text_field.dart';
import '../shared/parent_widget.dart';

class WidgetInteractions {
  static Map<String, WidgetOperations> map = LinkedHashMap();

  WidgetInteractions._privateConstructor() {
    _registerWidgets();
  }

  static WidgetInteractions instance = WidgetInteractions._privateConstructor();

  _registerWidgets() {
    map[WidgetTypes.CUSTOM_EDIT_TEXT] = CustomTextField();
  }

  bool validateWidget(ParentWidget field, String type) {
    return map[type]!.validate(field);
  }
}

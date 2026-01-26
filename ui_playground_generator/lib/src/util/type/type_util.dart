import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

class TypeUtil {
  static bool extendsImpaktfullUiComponentTheme(DartType type, String className) {
    final element = type.element;
    if (element is! InterfaceElement) {
      return false;
    }
    if (element.name == className) {
      return true;
    }
    for (final supertype in element.allSupertypes) {
      if (extendsImpaktfullUiComponentTheme(supertype, className)) {
        return true;
      }
    }
    return false;
  }
}

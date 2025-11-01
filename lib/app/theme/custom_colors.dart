
import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.accentColor,
    required this.darkTextColor,
  });

  final Color accentColor;
  final Color darkTextColor;

  @override
  CustomColors copyWith({Color? accentColor, Color? darkTextColor}) {
    return CustomColors(
      accentColor: accentColor ?? this.accentColor,
      darkTextColor: darkTextColor ?? this.darkTextColor,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      darkTextColor: Color.lerp(darkTextColor, other.darkTextColor, t)!,
    );
  }

  // Static getters for easy access to the colors (optional but helpful)
  static CustomColors of(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }
}

// *** បន្ថែមកូដ Extension នេះ ***
extension CustomColorsExtension on BuildContext {
  CustomColors get customColors => Theme.of(this).extension<CustomColors>()!;
}


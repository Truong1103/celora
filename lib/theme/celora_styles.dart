import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'celora_colors.dart';

class CeloraStyles {
  CeloraStyles._();

  static TextStyle serif({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSerif(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle sans({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static BoxDecoration cardDecoration({Color? backgroundColor}) {
    return BoxDecoration(
      color: backgroundColor ?? CeloraColors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: CeloraColors.pale),
      boxShadow: [
        BoxShadow(
          color: CeloraColors.dark.withValues(alpha: 0.07),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static InputDecoration inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: sans(fontSize: 15, color: CeloraColors.mute),
      filled: true,
      fillColor: CeloraColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CeloraColors.light, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CeloraColors.mid, width: 1.5),
      ),
    );
  }

  static ButtonStyle primaryButtonStyle({double? opacity}) {
    return ElevatedButton.styleFrom(
      backgroundColor: CeloraColors.dark,
      foregroundColor: CeloraColors.white,
      disabledBackgroundColor: CeloraColors.dark.withValues(alpha: 0.4),
      disabledForegroundColor: CeloraColors.white.withValues(alpha: 0.7),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: sans(fontSize: 14.5, fontWeight: FontWeight.w700),
    ).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final base = CeloraColors.dark;
        if (states.contains(WidgetState.disabled)) {
          return base.withValues(alpha: (opacity ?? 1) * 0.4);
        }
        return base.withValues(alpha: opacity ?? 1);
      }),
    );
  }

  static ButtonStyle ghostButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: CeloraColors.dark,
      backgroundColor: CeloraColors.white,
      side: const BorderSide(color: CeloraColors.light, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: sans(fontSize: 14.5, fontWeight: FontWeight.w700),
    );
  }
}

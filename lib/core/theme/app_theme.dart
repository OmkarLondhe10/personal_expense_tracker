import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {

  static ThemeData light = FlexThemeData.light(

    colors: const FlexSchemeColor(
      primary: Color(0xFF2563EB),
      primaryContainer: Color(0xFF3B82F6),
      secondary: Color(0xFF64748B),
      secondaryContainer: Color(0xFFF1F5F9),
      tertiary: Color(0xFF475569),
      tertiaryContainer: Color(0xFFF8FAFC),
      appBarColor: Color(0xFFF1F5F9),
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFFDAD6),
    ),

    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      elevatedButtonSchemeColor: SchemeColor.white,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
      outlinedButtonRadius: 8.0,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.white,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      listTileContentPadding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      alignedDropdown: true,
      searchBarBackgroundSchemeColor: SchemeColor.primaryContainer,
      searchViewBackgroundSchemeColor: SchemeColor.primaryContainer,
      searchBarRadius: 8.0,
      searchViewRadius: 8.0,
      navigationRailUseIndicator: true,
    ),

    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );


  static ThemeData dark = FlexThemeData.dark(

      colors: const FlexSchemeColor(
        primary: Color(0xFF60A5FA),
        primaryContainer: Color(0xFF1E3A8A),
        secondary: Color(0xFF94A3B8),
        secondaryContainer: Color(0xFF334155),
        tertiary: Color(0xFFCBD5E1),
        tertiaryContainer: Color(0xFF1E293B),
        appBarColor: Color(0xFF0F172A),
        error: Color(0xFFF87171),
        errorContainer: Color(0xFF7F1D1D),
      ),

    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      elevatedButtonSchemeColor: SchemeColor.white,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
      outlinedButtonRadius: 8.0,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      listTileContentPadding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      alignedDropdown: true,
      searchBarBackgroundSchemeColor: SchemeColor.primaryContainer,
      searchViewBackgroundSchemeColor: SchemeColor.primaryContainer,
      searchBarRadius: 8.0,
      searchViewRadius: 8.0,
      navigationRailUseIndicator: true,
    ),

    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

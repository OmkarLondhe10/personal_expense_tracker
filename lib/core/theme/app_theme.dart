import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.light(

    scheme: FlexScheme.shadBlue,
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
    scheme: FlexScheme.shadBlue,
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
